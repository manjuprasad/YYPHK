<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytags"%>

<html>
<head>
    <title>Arhatic Yoga Retreat - Search</title>
    <script type="text/javascript" src="<c:url value="/resources/script/jquery-1.7.2.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/script/jquery-ui-1.8.23.custom.min.js"/>"></script>
    <script type="text/javascript">
        $(function() {
            var moveLeft = 250;
            var moveDown = 200;
            $("a#submit").button();
            $("a#submit").css("font-size", "11px");
            $( "a#submit" ).click(function() {
                 $("#registrationCriteria").get(0).setAttribute('action', 'list.htm');
                 $("#registrationCriteria").submit();
            });

            $(".popup").click(function(e) {
                var divId = $(this).attr('id');
                $("div#"+divId).show()
                    .css('top', e.pageY - moveDown)
                    .css('left', e.pageX - moveLeft)
                    .css('position','absolute')
                    .css('overflow','auto')
                    .css({"background-color":"#FFFFFF","font-size":"15px"})
                    .css({"border":"2px solid #B8B8B8","padding":"15px"})
                    .css({"z-index":"100","box-shadow":"0 0 5px #C4C4C4"})
                    .height("150px")
                    .width("300px")
                    .appendTo('body');
            });

            $(".popupBoxClose").click(function() {
                var divId = $(this).attr('id');
                $("div#"+divId).hide();
            });

            $("select#foundation").change(function() {
                if ($(this).val() == "Others") {
                    $("#registrationCriteria input[name='otherFoundation']").val("");
                    $("div#othersTextBox").show();
                    $("div#othersTextBox").focus().select();
                }
                else {
                    $("div#othersTextBox").hide();
                }
            });

            $(document).ready(function() {
                if ($("select#foundation").val() == "Others") {
                    $("div#othersTextBox").show();
                    $("div#othersTextBox").focus().select();
                }
            });
        });
    </script>
</head>
<mytags:style/>
</head>
<body>
<mytags:menu/>
<h2 align="center">Search Participants</h2>

<form:form method="post" action="list.htm" commandName="registrationCriteria">

<table align="center" cellspacing="2">
    <tr>
        <td><form:label path="name"><spring:message code="label.name"/></form:label></td>
        <td><form:input path="name" /></td>
        <td><form:label path="foundation"><spring:message code="label.foundation"/></form:label></td>
        <td>
            <form:select path="foundation">
                <form:option value="" label="--- Select ---"/>
                <form:options items="${allFoundations}" />
            </form:select>
            <div id="othersTextBox" style="display:none;">
                    <form:input path="otherFoundation" size="60"/>
            </div>
        </td>
    </tr>
    <tr>
        <td><form:label path="email"><spring:message code="label.email"/></form:label></td>
        <td><form:input path="email" /></td>
        <td><form:label path="level"><spring:message code="label.level"/></form:label></td>
        <td>
            <form:select path="level">
                <form:option value="" label="--- Select ---"/>
                <form:options items="${allParticipantLevels}" />
            </form:select>
        </td>
    </tr>
    <tr>
        <td><form:label path="mobile"><spring:message code="label.mobile"/></form:label></td>
        <td><form:input path="mobile" /></td>
        <td><form:label path="seat"><spring:message code="label.seat"/></form:label></td>
        <td><form:input path="seat" /></td>
    </tr>
    <tr>
        <td><form:label path="eventId"><spring:message code="label.eventId"/></form:label></td>
        <td>
            <form:select path="eventId">
                <form:option value="" label="--- Select ---"/>
                <form:options items="${allEvents}" />
            </form:select>
        </td>
        <td><form:label path="vip"><spring:message code="label.vip"/></form:label></td>
        <td><form:checkbox path="vip"/></td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <div id="button">
                <a id="submit" href="#"><spring:message code="label.search"/></a>
            </div>
        </td>
    </tr>
</table>
</form:form>

<c:if  test="${!empty registrationList}">
<h3>Participants</h3>
<table class="data" border="1" cellpadding="1" cellspacing="1" width="100%">
<tr>
    <th><spring:message code="label.erid"/></th>
    <th><spring:message code="label.name"/></th>
    <th><spring:message code="label.email"/></th>
    <th><spring:message code="label.mobile"/></th>
    <th><spring:message code="label.foundation"/></th>
    <th><spring:message code="label.event"/></th>
    <th><spring:message code="label.level"/></th>
    <th><spring:message code="label.seat"/></th>
    <th><spring:message code="label.totalAmountPaid"/></th>
    <th><spring:message code="label.amountDue"/></th>
    <th><spring:message code="label.foodCoupon"/></th>
    <th><spring:message code="label.eventKit"/></th>
</tr>
<c:forEach items="${registrationList}" var="registration">
    <tr>
        <td><c:out value="${registration.id}"/></td>
        <td>
            <form id="updatePart<c:out value="${registration.id}"/>" method="post" action="updateRegistration.htm">
                <input type="hidden" name="registrationId" value="<c:out value="${registration.id}"/>" />
                <a href="#" onclick="document.getElementById('updatePart<c:out value="${registration.id}"/>').submit();">
                    <c:out value="${registration.participant.name}"/>
                </a>
            </form>
        </td>
        <td><c:out value="${registration.participant.email}"/></td>
        <td><c:out value="${registration.participant.mobile}"/></td>
        <td><c:out value="${registration.participant.foundation}"/></td>
        <td><c:out value="${registration.event.name}"/></td>
        <td><c:out value="${registration.levelName}"/></td>
        <div style="display:none;" id="seatsDisplay<c:out value="${registration.id}"/>">
            <c:if  test="${!empty registration.seats}">
                <c:forEach items="${registration.seats}" var="seat">
                    <c:if  test="${seat.seat != null}">
                        <ul class="tooltipBullet">
                            <li><c:out value="${seat.levelName}"/>&nbsp;-&nbsp;<c:out value="${seat.seat}"/></li>
                        </ul>
                    </c:if>
                </c:forEach>
            </c:if>
            <p align="center"></p><a class="popupBoxClose" href="#" id="seatsDisplay<c:out value="${registration.id}"/>">Close</a></p>
        </div>
        <td>
            <a class="popup" href="#" id="seatsDisplay<c:out value="${registration.id}"/>">
                <spring:message code="label.seat"/>
            </a>
        </td>
        <td>
            <form id="showPayments<c:out value="${registration.id}"/>" method="post" action="showPayments.htm">
                <input type="hidden" name="registrationId" value="<c:out value="${registration.id}"/>" />
                <a href="#" onclick="document.getElementById('showPayments<c:out value="${registration.id}"/>').submit();">
                    <c:out value="${registration.totalAmountPaid}"/>
                </a>
            </form>
        </td>
        <td><c:out value="${registration.amountDue}"/></td>
        <td><c:out value="${registration.foodCoupon}"/></td>
        <c:if  test="${registration.eventKit}">
            <td style="font-weight:bold; color:green; font-size:20px;">
                <c:out value="${registration.eventKit}"/>
            </td>
        </c:if>
        <c:if  test="${!registration.eventKit}">
            <td>
                <c:out value="${registration.eventKit}"/>
            </td>
        </c:if>
    </tr>
</c:forEach>
</table>
</c:if>
<mytags:footer/>
</body>
</html>
