<?php

class ProfileLocationMap extends LocationMap
{

    /** @var  bool */
    public $with_spirits;
    public $just_count;

    public function attributeNames()
    {
        return array_merge(
            parent::attributeNames(),
            array(
                'with_spirits',
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
                    array('with_spirits, just_count', 'boolean'),
                )
            );
    }


    /**
     * @return array
     */
    public function buildProfileMap()
    {
        $base_vector = $this->getBaseVector();
        $sql = '
            SELECT
                t.cx, t.cy, t.is_spirit,
                u.id,u.username,u.email, u.created_at,u.last_login, u.avatar_name
            FROM
                user_place t
            JOIN "user" u ON t.user_id = u.id
            WHERE (' . $this->makeLimits() . ') ' . (!$this->with_spirits ? ' AND t.is_spirit = false' : '') . '
            ORDER BY t.cx, t.cy
        ';
        $command = Yii::app()->db->createCommand($sql);

        $dataReader = $command->query();
        $result = array();

        while (($row = $dataReader->read()) !== false) {

            $point = new LocationPoint("{$row['cx']}:{$row['cy']}");
            $scaledPoint = $this->scalePoint($point, $base_vector->pa);

            $scaledVector = $this->scaledVector($point, $base_vector->pa);

            if (empty($result["$scaledPoint"])) {
                $result["$scaledPoint"] =
                    array(
                        "real_cxyxy" => "$scaledVector",
                        "scale_cxy" => "$scaledPoint",
                        'profiles' => $this->just_count ? 0 : array(),
                        'spirits' => $this->just_count ? 0 : array()
                    );
            }


            if (!$this->just_count) {
                $profile = array(
                    'id' => $row['id'],
                    'username' => $row['username'],
                    'name' => null,
                    'avatar' => User::getAvatarsPathsByImg($row['avatar_name']),
                    'created_at' => $row['created_at'],
                    'last_login' => $row['last_login'],
                );
                if (!$row['is_spirit']) {
                    if (empty($result["$scaledPoint"]['profiles']["$point"])) {
                        $result["$scaledPoint"]['profiles']["$point"] = array();
                    }
                    $result["$scaledPoint"]['profiles']["$point"][] = $profile;
                } else {
                    if (empty($result["$scaledPoint"]['spirits']["$point"])) {
                        $result["$scaledPoint"]['spirits']["$point"] = array();
                    }
                    $result["$scaledPoint"]['spirits']["$point"][] = $profile;
                }
            } else {
                if (!$row['is_spirit']) {
                    $result["$scaledPoint"]['profiles'] += 1;
                } else {
                    $result["$scaledPoint"]['spirits'] += 1;
                }

            }
        }
        return $result;
    }
} 