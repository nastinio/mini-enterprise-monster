<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>ЛК</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- Optional theme -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>

<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">EC</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="/ecare/${person.id}/info">Информация о профиле</a></li>
                <li><a href="/ecare/${person.id}/contracts">Контракты</a></li>
                <li><a href="/ecare/${person.id}/contract/${contract.id}/tariffs">Тарифы</a></li>
                <li><a href="/ecare/${person.id}/contract/${contract.id}/extraOptions">Дополнительные опции</a></li>

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">${contract.number}</a></li>
                <li><a href="#">${person.firstname} ${person.lastname}</a></li>
                <li><a href="/ecare/${person.id}/logout">Выйти</a></li>
                <%--<li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                    </ul>
                </li>--%>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

Подключенный тариф: ${contract.tariff.name} <br><br>

<c:choose>
    <c:when test="${contract.isBlockedByManager eq '1'}">
        Контракт заблокирован менеджером<br>
        Смена тарифа невозможна
    </c:when>

    <c:when test="${contract.isBlockedByPerson eq '1'}">
        Заблокирован пользователем<br>
        Смена тарифа и изменение опций невозможны
        <a href="<c:url value='/ecare/${person.id}/unlock/${contract.id}'/>" class="c">Разблокировать</a>
        <br>
    </c:when>

    <c:otherwise>
        Контракт активен
        <a href="<c:url value='/ecare/${person.id}/block/${contract.id}'/>" class="c">Заблокировать</a>
        <br>
        <c:if test="${!empty allTariffList}">
            <c:forEach items="${allTariffList}" var="tariff">
                Название тарифа: ${tariff.name}<br>
                <a href="<c:url value='/ecare/${person.id}/contract/${contract.id}/changeTariff/${tariff.id}'/>"
                   class="c">Сменить тариф</a><br>
                Опции тарифа:<br>

                <table class="table table-sm">
                    <thead>
                    <tr>
                        <th>Название</th>
                        <th>Стоимость подключения</th>
                        <th>Стоимость</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${tariff.optionSet}" var="optionTariff">
                        <tr>
                            <td>${optionTariff.name}</td>
                            <td>${optionTariff.connectionCostOption}</td>
                            <td>${optionTariff.costOption}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:forEach>
        </c:if>


        <c:if test="${!empty allOptionList}">
            Все возможные дополнительные опции:

            <table class="table table-sm">
                <thead>
                <tr>
                    <th>Название</th>
                    <th>Стоимость подключения</th>
                    <th>Стоимость</th>
                    <th>Подключить</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${allOptionList}" var="option">
                    <tr>
                        <td>${option.name}</td>
                        <td>${option.connectionCostOption}</td>
                        <td>${option.costOption}</td>
                        <td><a href="<c:url value='#'/>" class="c">Подключить</a><br>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>

    </c:otherwise>
</c:choose>


</body>
</html>
