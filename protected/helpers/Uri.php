<?php
class Uri
{
    /**
     * @param $param_name
     * @param $val
     * @param array $params_to_kill
     * @param null $uri
     * @param string $html_anch
     * @return string
     */
    public static function changeParam($param_name, $val, $params_to_kill = array(), $uri = null, $html_anch = '')
    {
        if (!$uri) {
            $uri = $_SERVER['REQUEST_URI'];
        }

        $url_params = parse_url($uri);
        $query_string = !empty($url_params['query']) ? $url_params['query'] : '';
        $query_path = $url_params['path'];

        parse_str($query_string, $params);

        foreach ($params_to_kill as $pk)
            if (isset($params[$pk]))
                unset ($params[$pk]);

        $params[$param_name] = $val;


        $new_url = $query_path . '?' . http_build_query($params) . ($html_anch ? ('#' . $html_anch) : '');

        return $new_url;
    }
}
