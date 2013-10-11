<?php
class FixtureCommand extends CConsoleCommand
{

    public function actionFixtureUsers()
    {
        for ($i = 3; $i < 1050; $i++) {
            //COPY "user" (id, username, email, key, created_at, updated_at, role, is_active, last_login, password) FROM stdin;
            $updated_at = $i % 5;
            $last_login = $i % 3;
            $created_at_str = date("Y-m-d H:i:s", strtotime("-$i days -$i hours -$i minutes"));
            $updated_at_str = date("Y-m-d H:i:s", strtotime("-" . ($i - 30) . " days -$i hours -$i minutes"));
            $last_login_str = date("Y-m-d H:i:s", strtotime("-" . ($i - 45) . " days -$i hours -$i minutes"));
            echo "$i	user$i	user$i@user.com	\N	" . $created_at_str . "	" . ($updated_at ? $updated_at_str : '\N') . "	user	t	" . ($last_login ? $last_login_str : '\N') . "	87dc1e131a1369fdf8f1c824a6a62dff\n";
        }
    }

    public function actionMakePlaces()
    {
        for ($i = 3; $i < 1050; $i++) {
            if($i % 3) {
                $user_place = new UserPlace();
                $user_place->user_id = $i;
                $user_place->name = "Place for user $i";
                $user_place->cx = rand(-50, 100);
                $user_place->cy = rand(-50, 100);
                $user_place->radius = rand(20, 49);
                $user_place->is_spirit = false;
                if($i % 4)
                    $user_place->updated_at = date("Y-m-d H:i:s", strtotime("-" . ($i - 30) . " days -$i hours -$i minutes"));
                $user_place->created_at = date("Y-m-d H:i:s", strtotime("-$i days -$i hours -$i minutes"));
                $user_place->save();
            }
        }
    }

    public function actionMakePlacesSpirit()
    {
        for ($j = 2; $j < 4; $j++)
            for ($i = 3; $i < 1050; $i++) {
                if($i % $j) {
                    $user_place = new UserPlace();
                    $user_place->user_id = $i;
                    $user_place->name = "Spirit Place for user $i";
                    $user_place->cx = rand(-50, 100);
                    $user_place->cy = rand(-50, 100);
                    $user_place->radius = rand(20, 49);
                    $user_place->is_spirit = true;
                    if($i % 5)
                        $user_place->updated_at = date("Y-m-d H:i:s", strtotime("-" . ($i - 30) . " days -$i hours -$i minutes"));
                    $user_place->created_at = date("Y-m-d H:i:s", strtotime("-$i days -$i hours -$i minutes"));
                    $user_place->save();
                }
            }
    }

    public function actionMakeTagPlaces()
    {

        $tags = array("tg2", "Taggg_with_max_length", "Русский_тэг_мой", "Simple_very_tag", "porno_is_666");
        for ($i = 300; $i < 900; $i++) {
            if($i % 3)
                continue;
            $tag = $tags[rand(0, 4)];
            $model = new TagPlace();
            $model->user_id = $i;
            $model->setScenario('tag_place_post');
            $model->tag_name = $tag;
            $model->created_at = date("Y-m-d H:i:s", strtotime("-$i days -$i hours -$i minutes"));
            $model->point = rand(-150, 550) . ':' . rand(-150, 550);
            if($model->validate()) {
                $model->save();

            } else {
                echo "skip\n";
            }


        }


    }
}
