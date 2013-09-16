<?php
class MailNotifier
{
    /**
     * @param CEvent $event
     */
    public function mailAboutNewFeedback(CEvent $event){
        /** @var $feedback CompanyFeedbacks */
        $feedback = $event->sender;
        $company = $feedback->company;
        foreach($feedback->company->subscribedUsers as $user){
            myMail::send($user->email,$feedback->createdBy->username." оставил ".($feedback->mark>0?'позитивный':($feedback->mark<0?'негативный':'новый'))." отзыв о компании «{$company->name}»",'notice_company_subscribe',array('feedback'=>$feedback),true);
        }
        //        echo($feedback->id);
    }

    /**
     * @param CEvent $event
     */
    public function mailEmployerAboutCompany(CEvent $event){
        /** @var $feedback CompanyFeedbacks */
        $feedback = $event->sender;
        $company = $feedback->company;
        if($company->countFeedbacks() == Yii::app()->params['fedbacks_nums_for_notice_company']){
            if($company->main_email){
                myMail::send($company->main_email,"Сотрудники и партнёры Вашей компании(«{$company->name}») оставили уже более ".Yii::app()->params['fedbacks_nums_for_notice_company']." отзывов о компании",'notice_employer',array('company'=>$company),true);
            }else{
                $company->need_notice_employer = true;
                $company->save();
            }
        }

    }

    /**
     * @param CEvent $event
     */
    public function mailAboutReplayedComment(CEvent $event){
        /** @var $comment CompanyFeedbacksComment */
        $comment = $event->sender;
        $company = $comment->company;
        if($comment->replay_to){
            $replayTo = $comment->replayTo->createdBy;
            if($company->hasSubscribe($replayTo))
                myMail::send($replayTo->email,$comment->createdBy->username." ответил на ваш комментарий в отзыве о компании {$company->name}",'notice_comment_replay',array('comment'=>$comment),true);
        }
    }

    public function mailAboutNewMessage(CEvent $event){
        /** @var $message Message */
        $message = $event->sender;
        $to_user = $message->toUser;

        if($to_user->needNewMessageEmailNotice($message->fromUser)){
            $from_user = $message->fromUser;
            myMail::send($to_user->email,$from_user->username." отправил вам новое сообщение",'notice_new_message',array('message'=>$message),true);
        }

    }


    public function mailAboutCompanyChecked(CEvent $event){
        /** @var $company Company */
        $company = $event->sender;
        myMail::send($company->createdBy->email,$company->name." отправил вам новое сообщение",'notice_company_checked',array('company'=>$company),false);
    }
}
































