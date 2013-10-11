<?php
/**
 * Class TagLocationMap
 *
 * @method string errorsAgg
 */
class TagLocationMap extends LocationMap
{

    public $limit;
    public $only_my;

    public function attributeNames()
    {
        return array_merge(
            parent::attributeNames(),
            array(
                'limit',
                'my_first'
            )
        );
    }


    public function rules()
    {
        return
            array_merge(
                parent::rules(),
                array(
                    array('limit', 'default', 'value' => Yii::app()->params['tag_get_limit_default']),
                    array('only_my', 'default', 'value' => 0),
                    array('only_my', 'boolean'),
                    array('only_my', 'unsafe'),
                    array('limit', 'numerical',
                        'integerOnly' => true,
                        'max' => Yii::app()->params['tag_get_limit_max'],
                        'min' => Yii::app()->params['tag_get_limit_min']
                    ),
                )
            );
    }

    public function behaviors()
    {
        return array(
            'ErrorsAggBehavior' => array(
                'class' => 'ext.behaviors.ErrorsAggBehavior'
            )
        );
    }


    /**
     * @return array
     */
    public function buildTagMap()
    {

        $sql = <<<SQL
            SELECT
                tp.tag_id, COUNT(tp.id) as tag_count, ARRAY_AGG(tp.user_id) as user_ids, tg.name
            FROM
                tag_place tp
            JOIN
              tag tg ON tg.id = tp.tag_id

            WHERE ({$this->makeLimits("tp")})
            GROUP BY tp.tag_id, tg.name
            ORDER BY COUNT(tp.id)
            LIMIT {$this->limit}
SQL;


        $command = Yii::app()->db->createCommand($sql);
        $dataReader = $command->query();
        $result = array();
        while (($tag_place = $dataReader->read()) !== false) {
            $user_ids = str_getcsv(trim($tag_place['user_ids'], '{}'));
            $my = (User::current() && in_array(User::current()->id, $user_ids)) ? true : false;
            if($this->only_my && !$my)
                continue;
            $result[$tag_place['name']] = array(
                "id" => $tag_place['tag_id'],
                "name" => $tag_place['name'],
                "count" => $tag_place['tag_count'],
                "my" => $my
            );
        }
        return $result;

    }

    /**
     * @param int $user_id
     * @param string $tag_name
     * @return array|null
     */
    public function findForUser($user_id, $tag_name)
    {
        return array();
    }
} 