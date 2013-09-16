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

    public function renderHtml($uri = null,$html_anch = '', $params_to_kill = array(), $just_next = false, $numGroup = 3, $backward = 'Назад',$forward="Вперёд")
    {
        Asse::addCss('paginator.css');
        Asse::addJs('paginator.js');
        $navigation = '';
        $num_pages = $this->getPageCount();
        $currPage = $this->getCurrentPage()+1;
        $page_name = $this->pageVar;

        if ($num_pages > 1) {
            if ($just_next) {
                if ($currPage < $num_pages) {
                    $navigation = '
                                <a class=""  href="' . Uri::changeParam($page_name, $currPage, $params_to_kill, $uri, $html_anch) . '">
                                    <span>'.$forward.'</span>
                                </a>
                           ';
                }
            } else {
                $count = null;
                $navigation .= '<div class="paginator"><span class="paginator-header">Страницы:</span>';
                if ($currPage - 1) {
                    $navigation .= '<a data-page="'.$page_name.'='.($currPage - 2).'"  class="paginator-prev" href="' . Uri::changeParam($page_name, $currPage - 2, $params_to_kill, $uri, $html_anch) . '"><big>«</big> '.$backward.'</a>';
                } else {
                    $navigation .= '<span class="paginator-prev"><big>«</big> '.$backward.'</span>';
                }


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
                            $navigation .= '<span class="paginator-dots">...</span>';
                        $mt = 'true';
                    } else
                    {
                        $mt = false;
                        if ($currPage != $i) {
                            $navigation .= '<a data-page="'.$page_name.'='.($i-1).'" href="' . Uri::changeParam($page_name, $i-1, $params_to_kill, $uri, $html_anch) . '">' . $i . '</a>';
                        } else {
                            $navigation .= '<span class="paginator-active">' . $i . '</span>';
                        }
                    }
                }

                if (($num_pages) != $currPage) {
                    $navigation .= '<a data-page="'.$page_name.'='.$currPage.'" class="paginator-next" href="' . Uri::changeParam($page_name, $currPage, $params_to_kill, $uri, $html_anch) . '">'.$forward.' <big>»</big></a>';
                } else {
                    $navigation .= '<span class="paginator-next">'.$forward.' <big>»</big></span>';
                }
                $navigation .= '</div>';
            }
        }

        return $navigation;

    }
}
