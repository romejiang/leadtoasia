upfile插件修改读取文件部分

pdf插件修改pdf文件参数和错误跳转部分

lookup插件修改了域对象  implements Serializable ，为了能在webflow的flow变量中使用

88902211

易捷
ServerAliveInterval 60
ServerAliveCountMax 3
test


客户加个手机字段@OK
生成项目号有问题@OK

在添加项目的时候选择行业@OK
添加项目给pm发送邮件@OK
在pm的菜单里加入新项目@OK

pm在完成项目之后，给销售发信，并确认（修改）最终字数。

销售人员和客户确认，更新项目状态为等待付款。
财务人员收到款项，核对金额后，更新项目状态为已付款，项目完成。

vm 可以管理所有译者，管理译者的价格，行业，登录信息，等等~~

销售经理像销售人员一样可以创建项目，可以看到所有销售人员建立的项目。按不同的人来分。@OK

销售经理可以按每个销售人员添加的客户来查看客户信息。@ok 


用户管理的顺序倒叙@ok
pm的首页报价中的项目，倒叙@ok

v的首页显示新任务。@OK
sales的首页是报价中的项目和

v提交项目是提示是是否要删除。

po pass之后就项目可以@OK
finish了~~不需要全部完成@OK

1@项目完成后，通过编辑字数和邮件内容，发给销售

1@添加po是匹配字数出错~~总是匹配到id：100去


不知道中间的环节是否有邮件通知：
1. PM确认项目
2. PM返回项目给sales

字数还是没有修改过来，还是没有进行计算

添加附件那里页面报错//跟文件有关系，，不知道为什么！！

项目和po的字数是一致的

1@vm只能看到译者默认是兼职一致


/////  接收销售人员提交的项目
    def accept = {
    加入发邮件功能。。。

    拒绝，返回，确认都发邮件给对方！！！



发送提醒信息，可以是中英文





