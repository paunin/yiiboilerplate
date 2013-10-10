<?php
/**
 * Class TagLocationMap
 *
 * @method string errorsAgg
 */
class TagLocationMap extends LocationMap
{

    /** @var  bool */
    public $just_count;

    public function attributeNames()
    {
        return array_merge(
            parent::attributeNames(),
            array(
                'just_count'
            )
        );
    }


    public function rules()
    {
        return
            array_merge(
                parent::rules(),
                array(
                    array('just_count', 'boolean'),
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

    }

    /**
     * @param int $user_id
     * @param string $tag_name
     * @return array|null
     */
    public function findForUser($user_id, $tag_name){
        return array();
    }
} 