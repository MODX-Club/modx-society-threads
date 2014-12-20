{$params=[ "limit" => 1, "current"=>1, "where" => [ "id" => $modx->resource->id ] ]}

{$processor = "society/web/topics/getdata"}

{processor action=$processor ns="modsociety" params=$params assign=result}
<section class="threadSection">
    {$object = $result.object}

    <section id="commentsSection">
        <div class="threadApp">
            {if $object.thread_id}
                {$params = [ "thread_id" => $object.thread_id, "limit" => 0 ]}
                {processor action="society/web/threads/comments/getdata" ns="modsociety" params=$params assign=comments_result}
                {if $object.comments_count}
                    <section class="threadSection">
                        <h3>Comments{if (int)$object.comments_count}({(int)$object.comments_count}){/if}</h3>
                    </section>
                {/if}
                {if $comments_result.success && $comments_result.object}
                    <section class="messageSection">
                        {$comments = $comments_result.object}
                        {include file='societychat/commentouter.tpl'}
                    </section>
                {/if}
            {/if}
        </div>

    </section>
</section>

<noindex>
    <script>
        var Society = {
            Topic: {
                targetId:{$modx->resource->id}
                ,targetClass:'SocietyTopic'
            },
            User: {
                id: '{$modx->user->id}' || 0
                ,username:'{$modx->user->username}'
            }
        }
    </script>
</noindex>

<script src="{$template_url}bundle/thread.react.js"></script>