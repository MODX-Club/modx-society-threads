<li> 
    <div>
        <a href="javascript:void(0)">
            {$comment.author_fullname|default:$comment.author_username}
        </a>
        <span>|</span>
        <small>{$comment.createdon}</small>
        <span>|</span>
        <span>
            <a
              href="javascript:void(0)"
              vote_direction="down"
              targetId="{$comment.id}"
            >↓
            </a>
            {$rating = (float)($comment.rating)}
            <span>{$rating}</span>
            <a
              href="javascript:void(0)"
              vote_direction="up"
              targetId="{$comment.id}"
            >↑
            </a>
        </span>
        <span>|</span>
        <span><a href="{$comment.resource_uri|default:$modx->resource->uri}">#</a></span>
    </div>
    <div>
        {$comment.text}
    </div>   


    {if $comment.children}
        {assign var=comments value=$comment.children}
        {include file="societychat/commentouter.tpl"}
    {/if}   

</li>