(window.webpackJsonp=window.webpackJsonp||[]).push([["website-bundle"],{"0fdc":function(e,t,a){},d3be:function(e,t,a){"use strict";a.r(t),a("96cf");var i,r=a("1da1"),n=(a("7f7f"),a("cadf"),a("551c"),a("097d"),a("0644")),s=a.n(n),o=a("2593"),l=a.n(o),c=a("9b02"),u=a.n(c),d=a("c641"),b=a.n(d),p=a("1119"),f=(a("28a5"),a("4917"),a("d4ec")),m=a("bee2"),v=a("99de"),h=a("7e84"),y=a("45eb"),w=a("262e"),g=a("257e"),k=a("ade3"),O=a("eed6"),I=a.n(O),T=a("91ff"),j=a("bc3a"),D=a.n(j),S=function(e){function t(){var e,a;Object(f.a)(this,t);for(var i=arguments.length,r=new Array(i),n=0;n<i;n++)r[n]=arguments[n];return a=Object(v.a)(this,(e=Object(h.a)(t)).call.apply(e,[this].concat(r))),Object(k.a)(Object(g.a)(Object(g.a)(a)),"title","订阅设置"),Object(k.a)(Object(g.a)(Object(g.a)(a)),"filter",{pageNo:1,pageSize:30}),Object(k.a)(Object(g.a)(Object(g.a)(a)),"successToast","提交成功"),Object(k.a)(Object(g.a)(Object(g.a)(a)),"failToast","提交失败"),Object(k.a)(Object(g.a)(Object(g.a)(a)),"subData",{name:"",fre:0,type:0,email:""}),Object(k.a)(Object(g.a)(Object(g.a)(a)),"downloadData",{fileName:"",type:0,begin:"",end:"",timeGranularity:"",metrics:"",filterFields:"",filterValues:""}),Object(k.a)(Object(g.a)(Object(g.a)(a)),"subDetail",{}),Object(k.a)(Object(g.a)(Object(g.a)(a)),"axioss",D.a.create({responseType:"arraybuffer"})),a}var a,i,n;return Object(w.a)(t,e),Object(m.a)(t,[{key:"init",value:(n=Object(r.a)(regeneratorRuntime.mark(function e(){return regeneratorRuntime.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:Object(y.a)(Object(h.a)(t.prototype),"init",this).call(this),this.listRequester=this.api.getSubscribeList,this.getSubscribeById=this.api.getSubscribeById,this.save=this.api.modifySubReport,this.ready=!0;case 5:case"end":return e.stop()}},e,this)})),function(){return n.apply(this,arguments)})},{key:"delete",value:(i=Object(r.a)(regeneratorRuntime.mark(function e(t){return regeneratorRuntime.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,D.a.delete("/v2/client/report/ssp-template/delete",{params:t});case 2:case"end":return e.stop()}},e,this)})),function(e){return i.apply(this,arguments)})},{key:"download",value:(a=Object(r.a)(regeneratorRuntime.mark(function e(t){return regeneratorRuntime.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,this.axioss.get("/v2/client/report/ssp-query/download",{params:t}).then(function(e){var t=e.headers["content-disposition"].match("(^|;)filename=([^;]*)(;|$)")[2],a=new Blob([e.data],{type:"application/octet-stream;charset=utf-8"}),i=document.createElement("a"),r=URL.createObjectURL(a);i.href=r,t=decodeURI(t),i.download=t,document.body.appendChild(i),i.click(),document.body.removeChild(i),URL.revokeObjectURL(r)}).catch(function(e){});case 2:case"end":return e.stop()}},e,this)})),function(e){return a.apply(this,arguments)})},{key:"submit",value:function(){var e=s()(this.subData.email);e=I()(e.split(";")).join(",");var t=this.subDetail,a={id:t.id,begin:t.begin,end:t.end,timeGranularity:t.timeGranularity,metrics:t.metrics.join(","),filterFields:t.filterFields.join(","),filterValues:t.filterValues.join("|"),contrastBegin:t.contrastBegin,contrastEnd:t.contrastEnd,name:this.subData.name,emails:e,emailFrequency:this.subData.fre,typeInfo:t.typeInfo,attachmentType:this.subData.type};return this.save(a)}},{key:"adaptData",value:function(e){return{result:e.results,totalCount:e.totalCount,pageNo:this.filter.pageNo,pageSize:this.filter.pageSize}}}]),t}(T.a),C=a("94c6"),N=a("8243"),x=a("af34"),_=a("076f"),R=a("7898"),V=a("e469"),E=a("927d"),F=a("ab80"),J=a("de74"),q=a("c9ac"),B=a("8631"),$=a("0090"),L=a("6235"),z=(a("4047"),a("90c0")),A=new z.a({alias:"PAUSE",text:"未订阅",value:2},{alias:"NORMAL",text:"已订阅",value:1},{alias:"DELETED",text:"订阅已取消",value:0}),U=new z.a({alias:"ONE",text:"一次",value:0},{alias:"DAY",text:"每天",value:1},{alias:"WEEKEND",text:"每周",value:2},{alias:"MONTH",text:"每月",value:3},{alias:"QUARTER",text:"每季度",value:4}),G=Object(C.a)(p.a,S,{name:"subscribe",components:{"list-view":p.a,"veui-table":N.a,"veui-table-column":x.a,"veui-pager":_.a,"veui-button":R.a,"veui-dialog":V.a,"veui-field":E.a,"veui-textarea":F.a,"veui-radio":J.a,"veui-select":q.a,"veui-input":B.a,"veui-form":$.a,"veui-icon":L.a},data:function(){return{freRule:[{label:"一次",value:0},{label:"每天",value:1},{label:"每周",value:2},{label:"每月",value:3},{label:"每季度",value:4}],saveFormType:[{value:0,label:"CSV"},{value:1,label:"EXCEL"}],rule:[{name:"required",value:!0,triggers:"blur,input"}],emailRule:[{name:"required",value:!0,priority:100},{triggers:"blur",name:"email",value:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/}],subscribeVisible:!1,deleteConfirm:!1,downloadVisible:!1}},methods:{getStatusText:function(e){return A.getTextFromValue(e)},getFreqText:function(e){return U.getTextFromValue(e)},getEmails:function(e){return 1<(e=e||[]).length?e.join("; ").substring(0,70)+"...":e[0]},redirectTo:function(e){this.global.redirect({url:{path:e},type:"push"})},handlerShowDetail:function(e){var t=this;this.store.getSubscribeById({id:e}).then(function(a){var i=a.result,r=l()(i,["dimensions","begin","end","timeGranularity","metrics","filterFields","filterValues","typeInfo"]),n=(r.metrics.join(","),r.filterFields?r.filterFields.join(","):""),s=r.filterValues?encodeURIComponent(r.filterValues.join("|")):"",o=(i.begin,i.end,i.timeGranularity,i.typeInfo?JSON.parse(i.typeInfo).adpId:""),c=i.typeInfo?JSON.parse(i.typeInfo).reportType:"";switch(t.global.reportfilterSelectItems=r,n&&s||(t.global.reportfilterSelectItems=""),c){case"":t.global.reportfilterSelectItems=null,t.redirectTo("/report/bidding");break;case"media-report":t.redirectTo("/report/media?id="+e);break;case"media-detail":var u=i.typeInfo?JSON.parse(i.typeInfo).websiteName:"",d=i.typeInfo?JSON.parse(i.typeInfo).websiteId:"";t.redirectTo("/report/media/detail/".concat(d,"/").concat(u));break;case"cpro":t.redirectTo("/report/bidding?id="+e);break;case"channel":t.redirectTo("/report/channel?id="+e);break;case"cpuunion":t.redirectTo("/report/content?id="+e);break;case"software":t.redirectTo("/report/tool-cn?id="+e);break;case"singleCn":var b=i.typeInfo?JSON.parse(i.typeInfo).cId:"",p=i.typeInfo?JSON.parse(i.typeInfo).cName:"";t.redirectTo("/report/tool-cn/".concat(p,"/").concat(b,"?id=")+e);break;case"hao123":t.redirectTo("/report/hao123?id="+e);break;case"whole":t.redirectTo("/report/whole?id="+e);break;case"cName":t.redirectTo("/report/cname?id="+e);break;case"cNameDetail":var f=i.typeInfo?JSON.parse(i.typeInfo).cName:"",m=i.typeInfo?JSON.parse(i.typeInfo).cId:"";t.redirectTo("/report/cname/detail/".concat(f,"/").concat(m,"?id=").concat(e));break;case"tool-channel":t.redirectTo("/report/tool-channel?id="+e);break;case"singleChannel":var v=i.typeInfo?JSON.parse(i.typeInfo).channelId:"",h=i.typeInfo?JSON.parse(i.typeInfo).cId:"";t.redirectTo("/report/tool-channel/".concat(h,"/").concat(v,"?id=").concat(e));break;case"adpreport":t.redirectTo("/report/adPosition?id="+e);break;case"adpsinglereport":t.redirectTo("/report/adPosition/".concat(o));break;case"searchChannel":t.redirectTo("/report/search/channel?id=".concat(e));break;case"searchChannelDetail":var y=i.typeInfo?JSON.parse(i.typeInfo).searchChannelName:"",w=i.typeInfo?JSON.parse(i.typeInfo).searchChannelId:"";t.redirectTo("/report/search/channel/detail/".concat(w,"/").concat(y,"?id=").concat(e));break;case"search":t.redirectTo("/report/search/cname?id=".concat(e));break;case"searchCNameDetail":var g=i.typeInfo?JSON.parse(i.typeInfo).cId:"",k=i.typeInfo?JSON.parse(i.typeInfo).cName:"";t.redirectTo("/report/search/cname/detail/".concat(g,"/").concat(k,"?id=").concat(e));break;default:var O=JSON.parse(i.typeInfo);if(O.unionBizTypeId)switch(O.unionBizTypeId){case 1:t.redirectTo("/report/bidding?id="+e);break;case 3:t.redirectTo("/report/search?id="+e);break;case 6:t.redirectTo("/report/tool-cn?id="+e);break;case 8:t.redirectTo("/report/hao123?id="+e);break;default:t.global.reportfilterSelectItems=null,t.redirectTo("/report/bidding")}else t.global.reportfilterSelectItems=null,t.redirectTo("/report/bidding")}})},handlerSubscribe:function(e){var t=this;this.store.getSubscribeById({id:e}).then(function(e){var a=e.result;t.store.subDetail=a,t.store.subData={name:a.name,fre:a.emailFrequency,type:a.attachmentType,email:a.emails?a.emails.join(";"):""},t.subscribeVisible=!0})},handlerDelete:function(e){this.deleteConfirm=!0,this.deleteId=e},handlerDownload:function(e){var t=this;this.store.getSubscribeById({id:e}).then(function(e){var a=e.result;t.store.downloadData={fileName:a.name,type:a.attachmentType,begin:a.begin,end:a.end,dimensions:a.dimensions.join(","),timeGranularity:a.timeGranularity,metrics:a.metrics.join(","),filterFields:a.filterFields.join(","),filterValues:a.filterValues.join("|")},t.downloadVisible=!0})},subCancel:function(){this.subscribeVisible=!1},handlerDeleteOk:function(){var e=this;this.store.delete({ids:this.deleteId}).then(function(t){e.store.submitSearch()})},handleSubmit:(i=Object(r.a)(regeneratorRuntime.mark(function e(){return regeneratorRuntime.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.prev=0,e.t0=this,e.next=4,this.store.submit();case 4:e.t1=e.sent,e.t0.handleSuccess.call(e.t0,e.t1),e.next=11;break;case 8:e.prev=8,e.t2=e.catch(0),this.handleError(e.t2);case 11:case"end":return e.stop()}},e,this,[[0,8]])})),function(){return i.apply(this,arguments)}),handleSuccess:function(e){this.store.successToast&&this.showToast(this.store.successToast,{type:"success"}),this.store.submitSearch(),this.subscribeVisible=!1},handleError:function(e){var t=this;this.store.failToast&&this.showToast(this.store.failToast,{type:"error"});var a=e.fields||e.field;a&&b()(a,function(e,a){var i=u()(t,"$refs.form.fieldsMap['".concat(a,"']"));i&&i.validities.unshift({valid:!1,message:e,fields:"backend:field"})})},downloadReport:function(){var e=this,t=s()(this.store.downloadData);t.fileName=this.store.downloadData.fileName+"."+(this.store.downloadData.type?"xls":"csv"),t.fileType=this.store.downloadData.type,this.store.download(t).then(function(t){e.downloadVisible=!1})},cancelDownload:function(){this.downloadVisible=!1}}}),M=(a("da1f"),a("2877")),P=Object(M.a)(G,function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("list-view",{staticClass:"subscribe-report-view"},[a("template",{slot:"tableColumns"},[a("veui-table-column",{attrs:{field:"name",title:"报告名称"}}),a("veui-table-column",{attrs:{field:"status",title:"订阅状态",width:"100"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("p",[e._v(e._s(e.getStatusText(t.item.status)))])]}}])}),a("veui-table-column",{attrs:{field:"freq",title:"发送频率",width:"100"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("p",[e._v(e._s(e.getFreqText(t.item.emailFrequency)))])]}}])}),a("veui-table-column",{attrs:{field:"email",title:"邮箱",width:"350"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("div",{domProps:{innerHTML:e._s(e.getEmails(t.item.emails))}})]}}])}),a("veui-table-column",{attrs:{field:"description",title:"操作",width:"300"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("veui-button",{attrs:{ui:"link"},on:{click:function(a){e.handlerShowDetail(t.item.id)}}},[e._v("查看")]),a("veui-button",{attrs:{ui:"link"},on:{click:function(a){e.handlerSubscribe(t.item.id)}}},[e._v("订阅设置")]),a("veui-button",{attrs:{ui:"link"},on:{click:function(a){e.handlerDelete(t.item.id)}}},[e._v("删除")]),a("veui-button",{attrs:{ui:"link"},on:{click:function(a){e.handlerDownload(t.item.id)}}},[e._v("下载")])]}}])})],1),a("veui-dialog",{attrs:{open:e.subscribeVisible,"overlay-class":"report-subscribe-set special-footer",title:"订阅设置"},on:{"update:open":function(t){e.subscribeVisible=t}}},[e.subscribeVisible?a("div",{staticClass:"inner"},[a("veui-form",{ref:"form",attrs:{data:e.store.subData},on:{submit:e.handleSubmit}},[a("div",{staticClass:"name"},[a("veui-field",{attrs:{label:"名称:",name:"name",field:"name",rules:e.rule}},[a("veui-input",{model:{value:e.store.subData.name,callback:function(t){e.$set(e.store.subData,"name",t)},expression:"store.subData.name"}})],1)],1),a("div",[a("div",{staticClass:"name"},[a("veui-field",{attrs:{label:"发送频率：",name:"fre",field:"fre",rules:e.rule}},[a("veui-select",{attrs:{options:e.freRule},model:{value:e.store.subData.fre,callback:function(t){e.$set(e.store.subData,"fre",t)},expression:"store.subData.fre"}})],1)],1),a("div",{staticClass:"name small"},[a("veui-field",{attrs:{label:"附件类型：",name:"type",field:"type",rules:e.rule}},e._l(this.saveFormType,function(t){var i=t.value,r=t.label;return a("veui-radio",{key:i,attrs:{value:i},model:{value:e.store.subData.type,callback:function(t){e.$set(e.store.subData,"type",t)},expression:"store.subData.type"}},[e._v(e._s(r))])}))],1),a("div",{staticClass:"text"},[a("veui-field",{attrs:{label:"收件人：",name:"email",field:"email",rules:e.emailRule}},[a("veui-textarea",{attrs:{placeholder:"邮箱地址以分号“;”隔开，最多支持10个",rows:"2"},model:{value:e.store.subData.email,callback:function(t){e.$set(e.store.subData,"email",t)},expression:"store.subData.email"}})],1)],1)]),a("div",{staticClass:"form-operation"},[a("veui-button",{staticClass:"overlay-button save",attrs:{ui:"primary",type:"submit"}},[e._v("保存订阅")]),a("veui-button",{staticClass:"overlay-button",on:{click:e.subCancel}},[e._v("取消")])],1)])],1):e._e(),a("template",{slot:"foot"},[a("div")])],2),a("veui-dialog",{attrs:{open:e.downloadVisible,"overlay-class":"report-subscribe-set",title:"下载设置"},on:{"update:open":function(t){e.downloadVisible=t}}},[e.downloadVisible?a("div",{staticClass:"inner"},[a("div",{staticClass:"gray-line"}),a("div",{staticClass:"name"},[a("span",{staticClass:"label"},[e._v("名称：")]),a("veui-input",{model:{value:e.store.downloadData.fileName,callback:function(t){e.$set(e.store.downloadData,"fileName",t)},expression:"store.downloadData.fileName"}})],1),a("div",{staticClass:"name small"},[a("span",{staticClass:"label"},[e._v("附件类型：")]),e._l(this.saveFormType,function(t){var i=t.value,r=t.label;return a("veui-radio",{key:i,attrs:{value:i},model:{value:e.store.downloadData.type,callback:function(t){e.$set(e.store.downloadData,"type",t)},expression:"store.downloadData.type"}},[e._v(e._s(r))])})],2)]):e._e(),a("template",{slot:"foot"},[a("veui-button",{staticClass:"overlay-button",attrs:{ui:"primary small"},on:{click:e.downloadReport}},[e._v("保存")]),a("veui-button",{staticClass:"overlay-button",attrs:{ui:"small"},on:{click:e.cancelDownload}},[e._v("取消")])],1)],2),a("veui-dialog",{attrs:{open:e.deleteConfirm},on:{"update:open":function(t){e.deleteConfirm=t},cancel:function(t){e.deleteConfirm=!1},ok:e.handlerDeleteOk}},[a("div",{staticClass:"delete-confirm-dialog"},[a("veui-icon",{attrs:{name:"info-circle-o"}}),a("p",[e._v("您确定要删除此订阅吗？")])],1)])],2)},[],!1,null,null,null);P.options.__file="SubscribeReportView.vue",t.default=P.exports},da1f:function(e,t,a){"use strict";var i=a("0fdc");a.n(i).a}}]);
//# sourceMappingURL=website-bundle.f2a0f12b.js.map