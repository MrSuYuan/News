<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%@ include file="/WEB-INF/report/meta.jsp" %>
    <title>查看报告</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/statics/common/report/css/zzsc.css">
    <script type="text/javascript" src="${ctx}/statics/common/report/js/appinfos.js"></script>
</head>
<body>

<div class="row cnaac-bg"><!--this-->
    <div class="container cnaac-bgw not-padding space-p-box space-p-bottom">
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="tab-one">
                <div class="row text-center">
                    <h3>应用安全常规检测报告</h3>
                    <div>检测时间：${scanDate }</div>
                </div>
                <div class="row">
                    <jsp:include page="/WEB-INF/report/report_include.jsp" flush="true">
                        <jsp:param value="1" name="scanType"/>
                    </jsp:include>
                    <!--
					  <c:if test="${not empty bangcleInfo }">
					  	  <div class="col-md-10 col-md-offset-1">
					  		<table class="table table-bordered table-striped">
								<caption><h4>代码层风险检测-<small>（梆梆扫描提供）</small></h4></caption>
						  		<tr>
									<td>${bangcleInfo }</td>
								</tr>
							</table>
						</div>
					  </c:if>
					   -->

                    <%-- <c:if test="${not empty malwareInfo }"></c:if>
                       <div class="col-md-10 col-md-offset-1">
                               <table class="table table-bordered table-striped">
                                 <caption><h4>应用风险行为</h4></caption>

                                     <tr>
                                         <th style="width: 230px;">应用风险等级</th>
                                             <c:choose>
                                                 <c:when test="${empty malwareInfo}"><td>N/A</td></c:when>
                                                 <c:when test="${malwareInfo.result eq 10}"><td class="danger">${malwareInfo.details.scan_type }</td></c:when>
                                                 <c:otherwise><td class="success">安全应用</td></c:otherwise>
                                             </c:choose>
                                     </tr>
                                     <tr>
                                         <th>病毒信息列表</th>
                                         <td>
                                             <c:if test="${empty malwareInfo or malwareInfo.result ne 10}">N/A</c:if>
                                             <c:if test="${malwareInfo.result eq 10 }">
                                                 <c:forEach items="${malwareInfo.details.scan_virus }" var="item">
                                                     <ul style="padding-left: 20px;">
                                                         <li>病毒名称：${item.name }</li>
                                                         <li>病毒描述：${item.info }</li>
                                                     </ul>
                                                 </c:forEach>
                                             </c:if>
                                         </td>
                                     </tr>
                                     <tr>
                                         <th>隐私泄露行为</th><td>
                                             <c:if test="${malwareInfo.result eq 10 }">
                                                 <c:out value="${malwareInfo.details.scan_privacy }">N/A</c:out></td>
                                             </c:if>
                                             <c:if test="${malwareInfo.result ne 10 }">N/A</c:if>
                                     </tr>
                                     <tr>
                                         <th>应用风险行为</th><td>
                                             <c:if test="${malwareInfo.result eq 10 }">
                                                 <c:out value="${malwareInfo.details.scan_risk }">N/A</c:out></td>
                                             </c:if>
                                             <c:if test="${malwareInfo.result ne 10 }">N/A</c:if>
                                     </tr>
                             </table>
                       </div>  --%>

                    <c:set var="scanRiskTypes" value="恶意扣费,隐私窃取,远程控制,恶意传播,资费消耗,系统破坏,诱骗欺诈,流氓行为" />
                    <c:if test="${not empty malwareInfo }"></c:if>
                    <div class="col-md-10 col-md-offset-1">
                        <table class="table table-bordered table-striped">
                            <caption><h4>应用风险行为</h4></caption>
                            <c:forTokens items="${scanRiskTypes }" delims="," var="scanRiskType">
                                <tr><th width="50%">${scanRiskType }</th><td>
                                    <c:choose>
                                        <c:when test="${empty malwareInfo}"><span class="text-muted"><span class="glyphicon glyphicon-question-sign"></span>未检测</span></c:when>
                                        <c:when test="${malwareInfo.result eq 10}">
                                            <c:choose>
                                                <c:when test="${fn:contains(malwareInfo.details.scan_risk, scanRiskType)}"><span class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span>存在—检测不通过</span></c:when>
                                                <c:otherwise><span class="text-success"><span class="glyphicon glyphicon-ok-circle"></span>不存在—检测通过</span></c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise><span class="text-success"><span class="glyphicon glyphicon-ok-circle"></span>不存在—检测通过</span></c:otherwise>
                                    </c:choose>
                                </td></tr>
                            </c:forTokens>
                        </table>
                    </div>

                    <c:if test="${not empty ijiamiSimpleList }">
                        <div class="col-md-10 col-md-offset-1">
                            <table class="table table-bordered table-striped">
                                <caption><h4>合规性检测<%---<small>（爱加密扫描提供）</small>--%></h4></caption>
                                <tr>
                                    <th rowspan="2">评估项目</th>
                                    <th colspan="4" class="text-center">评估结果</th>
                                </tr>
                                <tr>
                                    <th class="text-center">安全</th>
                                    <th class="text-center">低危</th>
                                    <th class="text-center">中危</th>
                                    <th class="text-center">高危</th>
                                </tr>
                                <c:forEach items="${ijiamiSimpleList }" var="item">
                                    <tr class="text-center">
                                        <td style="width: 230px;" class="text-left">${item.name }</td>
                                        <td class="success">${item.safeTotal }</td>
                                        <td class="info">${item.lowTotal }</td>
                                        <td class="warning">${item.midTotal }</td>
                                        <td class="danger">${item.highTotal }</td>
                                    </tr>
                                </c:forEach>
                                <tr><td colspan="5" class="text-center"><a><button class="btn btn-link" data-toggle="modal" data-target="#myModal">详情点击</button></a></td></tr>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${not empty ijiamiDetailList }">
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel"><img alt="爱加密" src="${ctx}/statics/common/report/images/logo_ijm.jpg" height="25px">检测详情-<small><c:out value="${basicInfo.appName }">N/A</c:out></small></h4>
                                    </div>
                                    <div class="modal-body" style="height: 700px;overflow: auto;">
                                        <c:forEach items="${ijiamiDetailList }" var="item">
                                            <c:if test="${item.isChild eq '1' }">
                                                <div><h4 >${item.name }</h4></div>
                                            </c:if>
                                            <c:if test="${item.isChild eq '0' and (!isUserView or item.result eq 10)}">
                                                <div style="margin-left: 8px;">
                                                    <h5>${item.name }</h5>
                                                    <table class="table table-bordered table-striped">
                                                        <tr>
                                                            <th style="width: 138px;">检测目的</th>
                                                            <td>${item.purpose }</td>
                                                        </tr>
                                                        <tr>
                                                            <th >重要等级</th>
                                                            <td>${item.grade }</td>
                                                        </tr>
                                                        <tr>
                                                            <th>危害描述</th>
                                                            <td>${item.harm }</td>
                                                        </tr>
                                                        <tr>
                                                            <th>检测结果</th>
                                                            <c:if test="${item.result eq 9}"><td class="success">受保护</td></c:if>
                                                            <c:if test="${item.result eq 10}">
                                                                <c:if test="${item.grade eq '高' }"><td class="danger">高危</td></c:if>
                                                                <c:if test="${item.grade eq '中' }"><td class="warning">中危</td></c:if>
                                                                <c:if test="${item.grade eq '低' }"><td class="info">低危</td></c:if>
                                                            </c:if>
                                                            <c:if test="${item.result eq 11}"><td class="success">安全</td></c:if>
                                                        </tr>
                                                        <tr>
                                                            <th>检测详情</th>
                                                            <td>${item.details }</td>
                                                        </tr>
                                                        <tr>
                                                            <th>解决方案</th>
                                                            <td>
                                                                <c:if test="${item.result ne 10}">N/A</c:if>
                                                                <c:if test="${item.result eq 10}">${item.solution }</c:if>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                    </c:if>




                    <c:if test="${not empty sj360Info }"></c:if>
                    <div class="col-md-10 col-md-offset-1">
                        <table class="table table-bordered table-striped">
                            <caption><h4>风险行为检测</h4></caption>
                            <tr>
                                <th width="230px">扫描结果</th>
                                <c:choose>
                                    <c:when test="${sj360Info.sign eq '未发现已知恶意'}"><td class="success">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '安全'}"><td class="success">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '谨慎'}"><td class="warning">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '危险'}"><td class="danger">${sj360Info.sign }</td></c:when>
                                    <c:otherwise><td>N/A</td></c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <th>行为描述</th>
                                <td><c:out value="${sj360Info.desc }">N/A</c:out></td>
                            </tr>
                        </table>
                    </div>
                    <!--
                    <div class="col-md-10 col-md-offset-1">
                        <table class="table table-bordered table-striped">
                            <caption><h4>权限隐私检测</h4></caption>
                            <tr>
                                <th width="230px">查看具体详情</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty BaiDuInfo.pdf_download_url}">
                                            <a href="${BaiDuInfo.pdf_download_url}">点击查看详情</a>
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <c:if test="${not empty sj360Info }"></c:if>

                    <div class="col-md-10 col-md-offset-1">
                        <table class="table table-bordered table-striped">
                            <caption><h4>人工检测</h4></caption>
                            <tr>
                                <th width="230px">权限隐私检测结果</th>
                                <td><c:out value="${privacyState }">N/A</c:out></td>
                                <%--  <c:choose>
                                      <c:when test="${sj360Info.sign eq '未发现已知恶意'}"><td class="success">${sj360Info.sign }</td></c:when>
                                      <c:when test="${sj360Info.sign eq '安全'}"><td class="success">${sj360Info.sign }</td></c:when>
                                      <c:when test="${sj360Info.sign eq '谨慎'}"><td class="warning">${sj360Info.sign }</td></c:when>
                                      <c:when test="${sj360Info.sign eq '危险'}"><td class="danger">${sj360Info.sign }</td></c:when>
                                      <c:otherwise><td>N/A</td></c:otherwise>
                                  </c:choose>--%>
                            </tr>
                            <tr>
                                <th>权限隐私检测描述</th>
                                <td><c:out value="${privacyContent }">N/A</c:out></td>
                            </tr>
                            <tr>
                                <th width="230px">内容检测结果</th>
                                <td><c:out value="${contentState }">N/A</c:out></td>
                                <%--<c:choose>
                                    <c:when test="${sj360Info.sign eq '未发现已知恶意'}"><td class="success">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '安全'}"><td class="success">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '谨慎'}"><td class="warning">${sj360Info.sign }</td></c:when>
                                    <c:when test="${sj360Info.sign eq '危险'}"><td class="danger">${sj360Info.sign }</td></c:when>
                                    <c:otherwise><td>N/A</td></c:otherwise>
                                </c:choose>--%>
                            </tr>
                            <tr>
                                <th>内容检测描述</th>
                                <td><c:out value="${contentText }">N/A</c:out></td>
                            </tr>
                        </table>
                    </div>
                    -->
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row text-center" style="font-size: 13px;line-height: 80px;border-top: solid #adadad 1px;">
    <div class="col-md-12 col-sm-12 col-xs-12">Copyright © 2018 CNAAC. All Rights Reserved 津ICP备05007879号-3</div>
</div>
</body>
</html>
