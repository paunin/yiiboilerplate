<?php

Yii::import('application.models._base.BaseFeedExternal');

class FeedExternal extends BaseFeedExternal
{
    const TYPE_RSS2 = 'rss2';

    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * @return int
     * @throws CException
     */
    public function parse()
    {
        switch ($this->parser_type) {
            case self::TYPE_RSS2:
                return $this->parseRss2();
                break;
            default:
                throw new CException(Yii::t('app', 'Undefined parser type for feed'));
                break;
        }
    }

    /**
     * @return string
     */
    private function getLastItemDate()
    {
        $last_date = "1990-01-01 00:00:00";
        $cr = new CDbCriteria();
        $cr->addCondition('feed_external_id = :feed_id');
        $cr->order = 'date DESC';
        $cr->limit = 1;
        $cr->params = array(':feed_id' => $this->id);
        /** @var FeedExternalItem $last_item */
        $last_item = FeedExternalItem::model()->find($cr);
        if ($last_item)
            $last_date = $last_item->date;

        return $last_date;
    }

    private function parseRss2()
    {
        $feed = simplexml_load_file($this->url);
        $count=0;
//      <title><![CDATA[​До России добрался смартфон Nokia Lumia 1020]]></title>
//      <link>http://www.you2you.ru/news/do-rossii-dobralsya-smartfon-nokia-lumia-1020</link>
//      <description><![CDATA[​До России добрался смартфон Nokia Lumia 1020. Новейший продукт от финской компании будет продаваться по цене в районе 24630 рублей на первых этапах продаж. Модель доступна в черном, белом и желтом цветовых решениях, получила прочный алюминиевый корпус со следующими габаритными размерами.]]></description>
//      <guid isPermaLink="false">news_14018</guid>
//      <pubDate>Wed, 16 Oct 2013 10:10:28 +0600</pubDate>

//        <item>
//            <title>Apple 22th October - ваше приглашение? #2</title>
//            <link>http://zodroid.ru/content/apple-22th-october-vashe-priglashenie-2/</link>
//            <description>&lt;p&gt;&lt;strong&gt;&lt;img style="display: block; margin-left: auto; margin-right: auto;"
//                src="../../../../media/uploads/files/22october.JPG" alt="" width="440" height="434" /&gt;&lt;/strong&gt;&lt;/p&gt;
//                &lt;p&gt;&amp;nbsp;&lt;/p&gt;
//                &lt;p&gt;&lt;strong&gt;Друзья&lt;/strong&gt;, компания Apple разослала официальное приглашение на
//                презентацию, которая пройдет 22 октября! Скорее всего на этой презентации Apple покажет новые iPad. А
//                именно iPad 5 и iPad mini 2. Примечательно, что в этом году Apple могут нас приятно удивить аж два раза!&lt;/p&gt;</description>
//            <guid>http://zodroid.ru/content/apple-22th-october-vashe-priglashenie-2/</guid>
//        </item>
        foreach ($feed->channel->item as $item) {
            $f_item = new FeedExternalItem();
            $f_item->guid = $item->guid ? : ($item->link ? : ($item->pubDate ? : md5($item->description)));
            $f_item->title = $item->title;
            $f_item->url = $item->link;
            $f_item->date = $item->pubDate ? date('Y-m-d H:i:s', strtotime($item->pubDate)) : null;
            $f_item->text = $item->description;
            $f_item->feed_external_id = $this->id;
            if ($f_item->validate())
                $f_item->save();
            else
                continue;
            $count++;

        }
        $this->last_parsing = date('Y-m-d H:i:s');
        $this->save();
        return $count;

    }
}