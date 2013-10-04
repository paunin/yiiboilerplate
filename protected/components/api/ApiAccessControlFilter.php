<?php
class ApiAccessControlFilter extends CAccessControlFilter{

    protected function preFilter($filterChain)
    {
        //@todo: check $_GET['token']
        return parent::preFilter($filterChain);
    }

    protected function accessDenied($user,$message)
    {
        return ApiController::actionError403();
        exit();
    }
}