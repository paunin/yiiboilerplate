<?php
class FeedCommand extends CConsoleCommand
{
    public function actionParse($feed_id)
    {

        /** @var FeedExternal $feed */
        $feed = FeedExternal::model()->findByPk($feed_id, 'is_active = true');
        if (!$feed)
            throw new CException('Feed with id = '.$feed_id.' not found');
        echo "Start parsing {$feed->name}\n";
        set_time_limit(300);
        $count = $feed->parse();

        echo "New $count items saved\n";
    }

    public function actionParseSome(array $feed_ids){
        foreach($feed_ids as $feed_id){
            $this->actionParse($feed_id);
        }
    }
}
