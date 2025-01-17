{extends file='tpl:comm.default'}
{$isSender=$USER.uid == $msg.byuid}
{block name='title'}
查看信息
{/block}
{block name='body'}
<div class="breadcrumb">
  收件箱：
  <a href="msg.index.chat.{if $msg.touid==$USER->uid}{$msg.byuid}{else}{$msg.touid}{/if}.{$bid}">聊天模式</a>
  <a href="msg.index.inbox.all.{$bid}">全部</a>
  <a href="msg.index.inbox.no.{$bid}">未读</a>
  <a href="msg.index.inbox.yes.{$bid}">已读</a>
  <a href="msg.index.send.{$bid}">发信</a>
</div>
<p>
  {if $isSender}
  <p>{if !$msg.isread}[对方未读] {/if}发给：<a href="msg.index.send.{$msg.touid}.{$bid}">{$msg.toname}</a></p>
  {else}
  <p>{if !$msg.isread}[新] {/if}来自：<a href="msg.index.send.{$msg.byuid}.{$bid}">{$msg.byname}</a></p>
  {/if}
  <p>发送时间：{date("Y-m-d H:i:s",$msg.ctime)}</p>
  <p>{if $msg.rtime}阅读时间：{date("Y-m-d H:i:s",$msg.rtime)}{/if}</p>
</p>
<hr>
<div class="user-content">{$ubbs->display($msg.content,true)}</div>
<hr>
<p>『快速回复』</p>
<p>
  <form action="msg.index.send.{if $isSender}{$msg.touid}{else}{$msg.byuid}{/if}.{$bid}" method="post">
    <textarea name="content" id="content"></textarea><br />
    <input type="submit" id="send_msg_button" name="go" value="{if $isSender}再发一条{else}回复{/if}"/>
    <input type="button" id="add_files" value="添加附件" onclick="addFiles()"/>
    <a id="ubbHelp" href="bbs.topic.80645.{$BID}">UBB说明</a>
    {include file="tpl:comm.addfiles"}
  </form>
</p>
<div class="breadcrumb">
  发件箱：
  <a href="msg.index.outbox.all.{$bid}">全部</a>
  <a href="msg.index.outbox.no.{$bid}">对方未读</a>
  <a href="msg.index.outbox.yes.{$bid}">对方已读</a>
  <a href="msg.index.@.{$bid}">@消息</a>
</div>
{/block}
