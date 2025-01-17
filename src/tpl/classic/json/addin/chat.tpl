{JsonPage::start()}

{JsonPage::selUbbP($ubbs)}

{foreach $list as $k=>$v}
    {$list.$k.uinfo = ['name'=>$v.uname]}
    {JsonPage::_unset($list.$k, 'uname')}
    {$tmp = $uinfo->uid($v.uid)}
    {$tmp = $uinfo->setUbbOpt($ubbs)}
    {$list.$k.content = $ubbs->display($v.content,true)}
    {$list.$k.canDel = !$v.hidden && $chat->canDel($v.uid,true)}
{/foreach}

{$jsonData=[
    'chatRomName'=>$roomname,
    'isLogin'=>$USER->islogin,
    'chatCount'=>$count,
    'currPage'=>$p,
    'maxPage'=>$maxP,
    'chatList'=>$list,
    'blockedReply'=>$blockedReply,
    'onlyReview'=>$onlyReview
]}

{if $USER->islogin}
	{$jsonData['token'] = $token->token()}
{/if}

{JsonPage::output($jsonData)}
