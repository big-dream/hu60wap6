{include file="tpl:comm.head" title="查看@消息"}
@消息：
{if !in_array($PAGE.ext[1],['yes','no'])}全部{else}<a href="msg.index.@.all.{$bid}">全部</a>{/if}&nbsp;
{if $PAGE.ext[1] == 'no'}未读{else}<a href="msg.index.@.no.{$bid}">未读</a>{/if}&nbsp;
{if $PAGE.ext[1] == 'yes'}已读{else}<a href="msg.index.@.yes.{$bid}">已读</a>{/if}
<hr />
{if $actionNotice}
<div class="action_notice">
    {$actionNotice|code}
</div>
<hr />
{/if}
{if $list}
<script>
    function checkCleanAll() {
        var req = prompt("您正在清空@消息，所有发给你的@消息（包括已读和未读）都将被永久删除，此操作不可恢复！\n" +
                         "请在输入框内输入“我要清空@消息”（不包括引号）并点击确认按钮。");
        if (req != '我要清空@消息') {
            alert('操作已取消');
            return false;
        }
        return true;
    }
</script>
<div class="msg_action">
<form action="{$PAGE->getUrl()}" method="post" style="display: inline-block; margin-right: 10px">
    <input type="hidden" name="clean" value="at">
    <input type="hidden" name="actionToken" value="{$actionToken}">
    <input type="submit" name="action" value="全部设为已读">
    <input type="submit" name="action" value="清空@消息" onclick="return checkCleanAll()">
</form>
<form action="{$PAGE->getUrl()}" method="get" style="display: inline-block">
  <input type="text" name="name" value="{$smarty.get.name|code}" placeholder="用户名" size="10" />
  <input type="submit" value="只看该用户" />
</form>
</div>
<hr />
{foreach $list as $i=>$k}
    <div class="msg_box">
	  <div class="floor-content user-content" data-floorID="{$i}" id="floor_content_{$i}">
        {$ubbs->display($k.content,true)}
      </div>
      <div class="floor_fold_bar" id="floor_fold_bar_{$i}"></div>
      时间：{date("Y-m-d H:i:s",$k.ctime)}
    </div>
    <hr />
{/foreach}
<div class="pager">
  {if $p < $maxP}<a href="?p={$p+1}&amp;uid={$uinfo.uid}">下一页</a>{/if}
  {if $p > 1}<a href="?p={$p-1}&amp;uid={$uinfo.uid}">上一页</a>{/if}
  {$p}/{$maxP}页,共{$msgCount}楼
  <input placeholder="跳页" id="page" size="2" onkeypress="if(event.keyCode==13){ location='?p='+this.value+'&uid={$uinfo.uid}'; }">
</div>
{else}
暂无@消息。
{/if}
<hr />
<a href="msg.index.inbox.all.{$bid}">收件箱</a> |
<a href="msg.index.outbox.all.{$bid}">发件箱</a> |
@消息 |
<a href="user.wechat.{$bid}">微信推送</a>: {$wechat = $USER->getinfo('wechat')}{if $wechat.uid}开{else}关{/if}

<script>
        $(document).ready(function(){
    // 自动折叠过长内容
                var maxHeight = 360;
                $(".floor-content").each(function(){
                        var that =$(this);
                        var id=this.getAttribute("data-floorID");
                        if(that.height() >  maxHeight){
                                that.height(maxHeight);
								var foldBar = document.querySelector('#floor_fold_bar_'+id);
								foldBar.style.borderTop = '1px solid #BED8EA';
								foldBar.style.borderBottom = '1px solid #BED8EA';
								foldBar.style.height = '24px';
								foldBar.style.textAlign = 'center';
                                $('#floor_fold_bar_'+id).html("<a href='#' data-floorID='"+id+"'>查看全部</a>");
                                $('#floor_fold_bar_'+id+">a").on('click',function(){
                                        var id=this.getAttribute("data-floorID");
                                        var that=$("#floor_content_"+id);
                                        // 不要使用that.height()进行判断，返回值是浮点数，不一定精确相等
                                        if(this.innerHTML == '折叠过长内容'){
                                                that.height(maxHeight);
                                                this.innerHTML='查看全部';
                                        }else{
                                                that.height(that[0].scrollHeight);
                                                this.innerHTML='折叠过长内容';
                                        }
                                });
                        }
                });
        });
</script>
{include file="tpl:comm.foot"}
