<?php
class SolrCommand extends CConsoleCommand
{
    public function actionBuildIndexes($instance='@all'){
        $film_solr = new ContentSolr();
        $client = $film_solr->getSolrConnection()->getClient();
        $client->deleteByQuery("*:*");

        $doc = new ContentSolr();
        $doc->id = '0';
        $doc->slug = 'slug';
        $doc->title = 'title';
        $doc->text = 'text';
        $list[] = $doc;

        ContentSolr::model()->getSolrConnection()->index($list);
        $client->request('<commit expungeDeletes="true" waitSearcher="false"/>');



    }
}
