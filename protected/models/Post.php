<?php

Yii::import('application.models._base.BasePost');
/**
 * Class Post
 *
 * @property Favorite[] favoritePosts
 * @property int likesCount
 * @property int childrenCount
 * @method array toArray
 *
 */
class Post extends BasePost
{
    public $point;

    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(
                array('user_id', 'exist', 'className' => 'User', 'attributeName' => 'id'),

                array('point', 'required', 'on' => 'post_post'),
                array('point', 'application.validators.CoordinatePointValidator', 'on' => 'post_post', 'makeCoordinates' => true),
                array('point', 'application.validators.CoordinatePointValidator', 'reanimateCoordinates' => true, 'makeCoordinates' => true, 'on' => 'post_put'),

                array('created_at', 'application.validators.TimeLimitValidator', 'message' => Yii::t('app', 'Too late to edit this post'), 'timeLimit' => Yii::app()->params['post_allow_edit_time'], 'on' => array('post_put', 'comment_put')),

                array('text', 'filter', 'filter' => array('HtmlTextFilter', 'filterRtf'), 'on' => array('post_post', 'post_put', 'comment_put', 'comment_post')),

                array('id, user_id, is_media, created_at, updated_at, cx, cy, cx_p_cy, cx_m_cy, post_id, point, deleted_at', 'unsafe', 'on' => array('post_post', 'post_put', 'comment_put', 'comment_post')),
                array('post_id', 'exist', 'className' => 'Post', 'allowEmpty' => false, 'attributeName' => 'id', 'on' => 'comment_post'),
            )
        );
    }

    public function relations()
    {
        $relations = parent::relations();

        $relations = array_merge(
            $relations,
            array(
                'favoritePosts' => array(self::HAS_MANY, 'Favorite', 'user_id', 'condition' => 'type = \'' . Favorite::TYPE_POST . '\''),
                'likesCount' => array(self::STAT, 'Favorite', 'favorite_id', 'condition' => 'type = \'' . Favorite::TYPE_POST . '\''),
                'childrenCount' => array(self::STAT, 'Post', 'post_id', 'condition' => 'deleted_at IS null'),
                'parent' => array(self::BELONGS_TO, 'Post', 'post_id'),
                'children' => array(self::HAS_MANY, 'Post', 'post_id'),
            )
        );
        return $relations;
    }

    public function behaviors()
    {
        return array(
            'TimestampBehavior' => array(
                'class' => 'ext.behaviors.TimestampBehavior',
            ),
            'SignableBehavior' => array(
                'class' => 'ext.behaviors.SignableBehavior.SignableBehavior',
                'createdByField' => 'user_id',
                'updatedByField' => null
            ),
            'ToArrayBehavior' => array(
                'class' => 'ext.behaviors.ToArrayBehavior.ToArrayBehavior',
                'fields' => array(
                    'id', 'subject', 'text', 'user_id', 'cx', 'cy', 'created_at', 'updated_at', 'deleted_at', 'post_id'
                )
            ),
            'coordinate' => array(
                'class' => 'ext.behaviors.CoordinateBehavior.CoordinateBehavior'
            ),
            'CAdvancedArBehavior' => array(
                'class' => 'application.extensions.behaviors.CAdvancedArBehavior'
            )
        );
    }

    /**
     * @return bool
     */
    public function delete()
    {
        $this->deleted_at = date('Y-m-d H:i:s');
        return $this->save();
    }


    public function afterSave()
    {
        $this->parseTags();
        $this->parseNames();
        return parent::afterSave();
    }
    /**
     * @return array
     */
    private function parseNames(){
        $pattern = '/@(' . Yii::app()->params['user_username_pattern'] . ')/iU';
        $matches = array();
        if(preg_match_all($pattern, $this->text, $matches)) {
            $count_down = Yii::app()->params['user_username_per_message_limit'];
            $user_names = array();

            foreach ($matches[1] as $user_name) {
                if(in_array($user_name,$user_names))
                    continue;
                if(!$count_down)
                    break;
                $user = User::model()->findByAttributes(array('username'=>$user_name));
                if(!$user)
                    continue;
                $user_names[] = $user_name;
                $pnm = new PostNameUser();

                $pnm->post_id = $this->id;
                $pnm->user_id = $user->id;

                if($pnm->save())
                    $count_down--;
            }
        }
        return $user_names;
    }

    /**
     * @return array
     */
    private function parseTags(){
        $pattern = '/#(' . Yii::app()->params['tag_pattern'] . ')/iU';
        $matches = array();
        if(preg_match_all($pattern, $this->text, $matches)) {
            $count_down = Yii::app()->params['tag_per_message_limit'];
            $tag_names = array();

            foreach ($matches[1] as $tag_name) {
                if(in_array($tag_name,$tag_names))
                    continue;
                if(!$count_down)
                    break;
                $tag = Tag::getOrCreate($tag_name);
                $tag_names[] = $tag->name;

                $tp = new TagPost();
                $tp->post_id = $this->id;
                $tp->tag_id = $tag->id;

                if($tp->save())
                    $count_down--;
            }
        }
        return $tag_names;
    }

    /**
     * @param int $comments_limit
     * @param int $comments_offset
     * @return array
     */
    public function toMiddleFormat($comments_limit = 0, $comments_offset = 0)
    {
        $result = $this->toArray();
        $result['user'] = $this->user->toFullProfile();
        $result['likes_count'] = $this->likesCount;
        $result['comment_count'] = $this->post_id ? 0 : $this->childrenCount;
        $result['comments'] = array();

        if($comments_limit && !$this->post_id) {
            $comments_offset = (int)$comments_offset;

            if(!is_numeric($comments_limit) || $comments_limit > Yii::app()->params['post_limit_max'])
                $comments_limit = Yii::app()->params['post_limit_max'];
            $cr = Post::getBaseCriteria();
            $cr->addCondition('post_id = :parent_id');
            $cr->params = array(':parent_id' => $this->id);
            $cr->limit = $comments_limit;
            $cr->offset = $comments_offset;

            $comments = Post::model()->with(array(
                'user' => array('together' => true, 'alias' => 'p_user'),
                'user.userCurrentPlace' => array('together' => true, 'alias' => 'p_u_place'),
            ))->findAll($cr);

            foreach ($comments as $comment) {
                /** @var Post $comment */
                $result['comments'][$comment->id] = $comment->toMiddleFormat(0);
            }
        }

        return $result;
    }

    /**
     * @return CDbCriteria
     */
    public static function getBaseCriteria()
    {
        $criteria = new CDbCriteria();
        $criteria->addCondition('t.deleted_at IS null');
        $criteria->order = 't.created_at DESC';

        return $criteria;
    }
}