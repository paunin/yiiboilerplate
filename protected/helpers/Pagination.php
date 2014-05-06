<?php
class Pagination extends CPagination
{
    private $_results = null;

    public function setResults($results)
    {
        return $this->_results = $results;
    }

    public function getResults()
    {
        return $this->_results;
    }

    public function renderHtml($uri = null,$html_anch = '', $params_to_kill = array(), $just_next = false, $numGroup = 3, $backward = "&laquo;",$forward="&raquo;")
    {

        $navigation = '';
        $num_pages = $this->getPageCount();
        $currPage = $this->getCurrentPage()+1;
        $page_name = $this->pageVar;

        if ($num_pages > 1) {
            if ($just_next) {
                if ($currPage < $num_pages) {
                    $navigation = $this->renderItem(Uri::changeParam($page_name, $currPage, $params_to_kill, $uri, $html_anch),$forward,false,false);
                }
            } else {
                $count = null;
                $navigation .= '<ul class="pagination">';
                $navigation .= $this->renderItem(Uri::changeParam($page_name, $currPage - 2, $params_to_kill, $uri, $html_anch),$backward,false,!($currPage - 1>0));

                $mt = false;
                for ($i = 1; $i < $num_pages + 1; $i++)
                {
                    if (
                        (
                            $i < ($currPage - ceil(($numGroup - 1) / 2)) ||
                            $i > ($currPage + ceil(($numGroup - 1) / 2))
                        ) && (
                            $i - 1 > ($numGroup - 1) &&
                            $i - 1 < ($num_pages - $numGroup)
                        )
                    ) {
                        if (!$mt)
                            $navigation .= $this->renderItem("#",'...',false,true);
                        $mt = 'true';
                    } else
                    {
                        $mt = false;
                        $navigation .= $this->renderItem(Uri::changeParam($page_name, $i-1, $params_to_kill, $uri, $html_anch),$i,$currPage == $i);

                    }
                }


                $navigation .= $this->renderItem(Uri::changeParam($page_name, $currPage, $params_to_kill, $uri, $html_anch),$forward,false,$num_pages == $currPage);

                $navigation .= '</ul>';
            }
        }

        return $navigation;
    }
    public function renderItem($url,$label=null,$active=false,$disable=false){
        return '<li class="'.($disable?'disabled ':'').($active?'active':'').'"><a href="' . $url . '">'.$label.($active?'<span class="sr-only">(current)</span>':'').'</a></li>';
    }
}
