<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="period" select='day'/>
  <xsl:variable name="date" select='5.7.2021'/>
  <xsl:variable name="mode" select='calendar'/>

  <xsl:template match="/">
    <xsl:if test="$mode = 'calendar'">
      <html>
        <head>
          <link rel="stylesheet" href="../css/calendarView.css"/>
        </head>
        <body>
          <xsl:choose>
            <xsl:when test="$period = 'day'">
              <xsl:call-template name="dayCalendar"/>
            </xsl:when>
            <xsl:when test="$period = 'week'">
              <xsl:call-template name="weekCalendar"/>
            </xsl:when>
            <xsl:when test="$period = 'month'">
              <xsl:call-template name="monthCalendar"/>
            </xsl:when>
          </xsl:choose>
        </body>
      </html>
    </xsl:if>

    <xsl:if test="$mode = 'project'">
      <html>
        <head>
          <link rel="stylesheet" href="../css/projectView.css"/>
          <link rel="stylesheet" href="../css/master.css"/>
          <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"/>
        </head>
        <body>
          <xsl:variable name="startwithoutzeros">
            <xsl:call-template name="erliestStart">
              <xsl:with-param name="path" select="calendar/items"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="start">
            <xsl:choose>
              <!--koennte man das mit nur zwei "when" testen einmal fuer monat und einmal fuer tag?-->
              <xsl:when test="string-length(substring-before($startwithoutzeros, '.'))=1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.'))=1">
                <xsl:value-of select="concat(0,substring-before($startwithoutzeros, '.'),'.',0,substring-after($startwithoutzeros, '.'))"/>
              </xsl:when>
              <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 2">
                <xsl:value-of select="concat(0, $startwithoutzeros)"/>
              </xsl:when>
              <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 2 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 1">
                <xsl:value-of select="concat(substring-before($startwithoutzeros, '.'), '.',0,substring-after($startwithoutzeros, '.'))"/>
              </xsl:when>
              <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 2 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 2">
                <xsl:value-of select="$startwithoutzeros"/>
              </xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="end">
            <xsl:call-template name="latestEnd">
              <xsl:with-param name="path" select="calendar/items"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="earliestStartJulian">
            <xsl:call-template name="calculateJulianDay">
              <xsl:with-param name="date" select="$start"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="latestEndJulian">
            <xsl:call-template name="calculateJulianDay">
              <xsl:with-param name="date" select="$end"/>
            </xsl:call-template>
          </xsl:variable>
          <table>
            <tr>
              <xsl:call-template name="DrawBackgroundLinesAndHeadDate">
                <xsl:with-param name="iterationtimes" select="$latestEndJulian - $earliestStartJulian"/>
                <xsl:with-param name="date" select="$start"/>
              </xsl:call-template>
            </tr>
            <xsl:call-template name="DrawDivsInLines">
              <xsl:with-param name="path" select="calendar/items"/>
              <xsl:with-param name="startJulian" select="$earliestStartJulian"/>
              <xsl:with-param name="endJulian" select="$latestEndJulian"/>
            </xsl:call-template>
          </table>
        </body>
      </html>
    </xsl:if>
  </xsl:template>

  <xsl:template name="dayCalendar">
    <!--This method generates the day based Calendar-->
    <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
    </xsl:variable>

    <div class="background">
      <div class="leftBar">
        <div class="timeBar" style="margin-top: 0;"> 00:00 Uhr </div>
        <div class="timeBar" style="margin-top: 4.16%;"> 01:00 Uhr </div>
        <div class="timeBar" style="margin-top: 2*4.16%;"> 02:00 Uhr </div>
        <div class="timeBar" style="margin-top: 3*4.16%;"> 03:00 Uhr </div>
        <div class="timeBar" style="margin-top: 4*4.16%;"> 04:00 Uhr </div>
        <div class="timeBar" style="margin-top: 5*4.16%;"> 05:00 Uhr </div>
        <div class="timeBar" style="margin-top: 6*4.16%;"> 06:00 Uhr </div>
        <div class="timeBar" style="margin-top: 7*4.16%;"> 07:00 Uhr </div>
        <div class="timeBar" style="margin-top: 8*4.16%;"> 08:00 Uhr </div>
        <div class="timeBar" style="margin-top: 9*4.16%;"> 09:00 Uhr </div>
        <div class="timeBar" style="margin-top: 10*4.16%;"> 10:00 Uhr </div>
        <div class="timeBar" style="margin-top: 11*4.16%;"> 11:00 Uhr </div>
        <div class="timeBar" style="margin-top: 12*4.16%;"> 12:00 Uhr </div>
        <div class="timeBar" style="margin-top: 13*4.16%;"> 13:00 Uhr </div>
        <div class="timeBar" style="margin-top: 14*4.16%;"> 14:00 Uhr </div>
        <div class="timeBar" style="margin-top: 15*4.16%;"> 15:00 Uhr </div>
        <div class="timeBar" style="margin-top: 16*4.16%;"> 16:00 Uhr </div>
        <div class="timeBar" style="margin-top: 17*4.16%;"> 17:00 Uhr </div>
        <div class="timeBar" style="margin-top: 18*4.16%;"> 18:00 Uhr </div>
        <div class="timeBar" style="margin-top: 19*4.16%;"> 19:00 Uhr </div>
        <div class="timeBar" style="margin-top: 20*4.16%;"> 20:00 Uhr </div>
        <div class="timeBar" style="margin-top: 21*4.16%;"> 21:00 Uhr </div>
        <div class="timeBar" style="margin-top: 22*4.16%;"> 22:00 Uhr </div>
        <div class="timeBar" style="margin-top: 23*4.16%;"> 23:00 Uhr </div>
      </div>

      <div class="topBar">
        <div class="title">
          <xsl:choose >
            <xsl:when test="$dayOfDate=1">
            Montag
            </xsl:when>
            <xsl:when test="$dayOfDate=2">
            Dienstag
            </xsl:when>
            <xsl:when test="$dayOfDate=3">
            Mittwoch
            </xsl:when>
            <xsl:when test="$dayOfDate=4">
            Donnerstag
            </xsl:when>
            <xsl:when test="$dayOfDate=5">
            Freitag
            </xsl:when>
            <xsl:when test="$dayOfDate=6">
            Samstag
            </xsl:when>
            <xsl:when test="$dayOfDate=0">
            Sonntag
            </xsl:when>
        </xsl:choose>
        </div>
      </div>
    
      <xsl:call-template name="insertDay">
        <xsl:with-param name="date" select="$date"/>
      </xsl:call-template>
    </div>
  </xsl:template>

  <xsl:template name="weekCalendar">
    <!--This method generates the week based Calendar-->
    <div class="tableDiv">
      <table>
        <thead>
          <th>
            <p>Montag</p>
          </th>
          <th>
            <p>Dienstag</p>
          </th>
          <th>
            <p>Mittwoch</p>
          </th>
          <th>
            <p>Donnerstag</p>
          </th>
          <th>
            <p>Freitag</p>
          </th>
          <th>
            <p>Samstag</p>
          </th>
          <th>
            <p>Sonntag</p>
          </th>
        </thead>
        <tbody>
          <tr class="daydiv">
            <td id="leftBorder">
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="1"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="2"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="3"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="4"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="5"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="6"/>
              </xsl:call-template>
            </td>
            <td id="rightBorder">
              <xsl:call-template name="insertWeek">
                <xsl:with-param name="day" select="0"/>
              </xsl:call-template>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="monthCalendar">
    <!--This method generates the month based Calendar-->
    <div class="tableDiv">
      <table>
        <thead>
          <th>
            <p>Mo</p>
          </th>
          <th>
            <p>Di</p>
          </th>
          <th>
            <p>Mi</p>
          </th>
          <th>
            <p>Do</p>
          </th>
          <th>
            <p>Fr</p>
          </th>
          <th>
            <p>Sa</p>
          </th>
          <th>
            <p>So</p>
          </th>
        </thead>
          <xsl:call-template name="createTable">
            <xsl:with-param name="row" select="5"/>
            <xsl:with-param name="i" select="1"/>
            <xsl:with-param name="col" select="7"/>
            <xsl:with-param name="j" select="1"/>
          </xsl:call-template>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="insertDay">
    <xsl:param name="date"/>
    
    <xsl:for-each select="calendar/items/milestones/milestone">
      <xsl:sort select="duetime/@val" data-type="number"/>
        <xsl:if test="duedate/@val=$date">
        
          <xsl:variable name="timeVal">
            <xsl:call-template name="getTimeValue">
              <xsl:with-param name="time" select="duetime/@val"/>
            </xsl:call-template>
          </xsl:variable>
          
          <div class="milestone dayEntry" style="{concat('margin-top:', $timeVal ,'%;')}">
            <p> <xsl:value-of select="name/@val"/> </p>
            <p> <xsl:value-of select="duedate/@val"/> </p>
          </div>
        </xsl:if>
    </xsl:for-each>

    <!-- <xsl:for-each select="calendar/items/tasks/task">

      <xsl:sort select="duetime/@val" data-type="number"/>

        <xsl:if test="duedate/@val=$date">
          <div class="task">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
              <p>
                <xsl:value-of select="duetime/@val"/> Uhr
              </p>  
          </div>  
        </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="calendar/items/appointments/appointment">
      <xsl:sort select="startTime/@val" data-type="number"/>

      <xsl:if test="startDate/@val=$date">
        <div class="appointment">
            <p>
              <xsl:value-of select="name/@val"/>
            </p>
            <p>
              <xsl:value-of select="startDate/@val"/>
            </p>
            <p>
                  <xsl:value-of select="startTime/@val"/> Uhr
            </p>
        </div>
      </xsl:if>
    </xsl:for-each> -->
  </xsl:template>

  <xsl:template name="insertWeek">
    <!--This method places the items based on their date and
    filtered by a day (val 0-6) into the calendar -->
    <!--ToDo:Make 1 Method for every view-->

    <xsl:param name="day"/>
    <!--Add milestones to calendar-->
    <xsl:for-each select="calendar/items/milestones/milestone">
      <xsl:sort select="duetime/@val" data-type="number"/>

      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="duedate/@val"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentWeekInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$date"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentWeekInt"/>

        <xsl:if test="$check &lt; 6">
          <xsl:if test="$check >=0">
            <div class="milestone">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="duetime/@val"/>
                Uhr
              </p> -->
            </div>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>

    <!--Add tasks to calendar-->
    <xsl:for-each select="calendar/items/tasks/task">
      <xsl:sort select="duetime/@val" data-type="number"/>
      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="duedate/@val"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentWeekInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$date"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentWeekInt"/>

        <xsl:if test="$check &lt; 6">
          <xsl:if test="$check >=0">
            <div class="task">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="duetime/@val"/>
    Uhr
              </p>
              <p>
                <xsl:value-of select="desc"/>
              </p> -->
            </div>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>

    <!--Add appointmens to calendar-->
    <xsl:for-each select="calendar/items/appointments/appointment">
      <xsl:sort select="startDate/@val" data-type="number"/>
      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="startDate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="startDate/@val"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentWeekInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$date"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentWeekInt"/>

        <xsl:if test="$check &lt; 6">
          <xsl:if test="$check >=0">
            <div class="appointment">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="startDate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="startTime/@val"/>
    Uhr
              </p>
              <p>
                <xsl:value-of select="desc"/>
              </p> -->
            </div>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="insertMonth">
    <!--This method places the items based on their date and
    filtered by a day (val 0-6) into the calendar -->
    <!--ToDo:Make 1 Method for every view-->
    <xsl:param name="day"/>
    <xsl:param name="i"/>

    <xsl:variable name="monthDate">
      <xsl:call-template name="getFirstDayOfMonth">
        <xsl:with-param name="date" select="$date"/>
      </xsl:call-template>  
    </xsl:variable>
    <!--Add milestones to calendar-->
    <xsl:for-each select="calendar/items/milestones/milestone">
      <xsl:sort select="duetime/@val" data-type="number"/>

      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="duedate/@val"/>
          </xsl:call-template>
        </xsl:variable>


        <xsl:variable name="currentMonthInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentMonthDay">
          <xsl:call-template name="getDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentMonthInt"/>

        <xsl:if test="$check &lt; ($i - 1 ) *7 + $currentMonthDay">
          <xsl:if test="$check >= ($i - 2 ) * 7 + $currentMonthDay">
            <div class="milestone">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="duetime/@val"/>
    Uhr
              </p> -->
            </div>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="calendar/items/appointments/appointment">
      <xsl:sort select="startTime/@val" data-type="number"/>

      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="startDate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="startDate/@val"/>
          </xsl:call-template>
        </xsl:variable>


        <xsl:variable name="currentMonthInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentMonthDay">
          <xsl:call-template name="getDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentMonthInt"/>
        <xsl:if test="$check &lt; ($i - 1 )  *7 + $currentMonthDay">
          <xsl:if test="$check >= ($i - 2 ) * 7 + $currentMonthDay">
            <div class="appointment">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="startDate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="duetime/@val"/>
    Uhr
              </p> -->
            </div>
          </xsl:if>
        </xsl:if> 
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="calendar/items/tasks/task">
      <xsl:sort select="duetime/@val" data-type="number"/>

      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$dayOfDate=$day">

        <xsl:variable name="currentDateInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="duedate/@val"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentMonthInt">
          <xsl:call-template name="calculateJulianDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="currentMonthDay">
          <xsl:call-template name="getDay">
            <xsl:with-param name="date" select="$monthDate"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="check" select="$currentDateInt - $currentMonthInt"/>

        <xsl:if test="$check &lt; ($i - 1 ) *7 + $currentMonthDay">
          <xsl:if test="$check >= ($i - 2 ) * 7 +$currentMonthDay">
            <div class="task">
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
              <!-- <p>
                <xsl:value-of select="duetime/@val"/>
              Uhr
              </p> -->
            </div>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="getDay">
    <!--This method takes a date and calculates the corresponding day of the week Sunday=0, Monday=1...Saturday=6-->
    <xsl:param name="date"/>
    <xsl:param name="day" select="substring-before($date,'.')"/>
    <xsl:param name="month" select="substring-before(substring-after($date,'.'),'.')"/>
    <xsl:param name="year" select="substring-after(substring-after($date,'.'),'.')"/>

    <xsl:variable name="a" select="floor((14 - $month) div 12)"/>
    <xsl:variable name="y" select="$year - $a"/>
    <xsl:variable name="m" select="$month + 12 * $a - 2"/>

    <xsl:value-of select="($day + $y + floor($y div 4) - floor($y div 100) 
    + floor($y div 400) + floor((31 * $m) div 12)) mod 7"/>
  </xsl:template>

  <xsl:template name="calculateJulianDay">
    <!--This method converts a date into an int in order to get the days between to dates-->
    <xsl:param name="date"/>
    <xsl:param name="day" select="substring-before($date,'.')"/>
    <xsl:param name="month" select="substring-before(substring-after($date,'.'),'.')"/>
    <xsl:param name="year" select="substring-after(substring-after($date,'.'),'.')"/>

    <xsl:variable name="a" select="floor((14 - $month) div 12)"/>
    <xsl:variable name="y" select="$year + 4800 - $a"/>
    <xsl:variable name="m" select="$month + 12 * $a - 3"/>

    <xsl:value-of select="$day + floor((153 * $m + 2) div 5) + $y * 365 + floor($y div 4) - floor($y div 100) + floor($y div 400) - 32045"/>
  </xsl:template>

  <xsl:template name="getFirstDayOfMonth">
    <!--method to get first day of month-->
    <xsl:param name="date"/>
    <xsl:param name="month" select="substring-before(substring-after($date,'.'),'.')"/>
    <xsl:param name="year" select="substring-after(substring-after($date,'.'),'.')"/>

    <xsl:value-of select="concat('1.',$month, '.', $year)"/>
  </xsl:template>

  <xsl:template name="createTable">
    <!--method to create month Table-->
    <xsl:param name="row"/>
    <xsl:param name="i"/>
    <xsl:param name="col"/>
    <xsl:param name="j"/>
   
    <xsl:if test="$i &lt;= $row">
    <tbody class="limitDiv">
      <tr> 
        <xsl:call-template name="createRows">
          <xsl:with-param name="col" select="$col"/>
          <xsl:with-param name="j" select="$j"/>
          <xsl:with-param name="i" select="$i"/>
        </xsl:call-template>
      </tr>
    </tbody>  
    </xsl:if>

    <xsl:if test="$i &lt;= $row">
      <xsl:call-template name="createTable">
        <xsl:with-param name="row" select="$row"/>
        <xsl:with-param name="i" select="$i + 1"/>
        <xsl:with-param name="col" select="$col"/>
        <xsl:with-param name="j" select="$j"/>
      </xsl:call-template>
    </xsl:if>  
  </xsl:template>

  <xsl:template name="createRows">
    <!--method to create table row-->
    <xsl:param name="col"/>
    <xsl:param name="j"/>
    <xsl:param name="i"/>

    <xsl:if test="$j &lt;= $col">
      <xsl:call-template name="createCols">
        <xsl:with-param name="j" select="$j"/>
        <xsl:with-param name="i" select="$i"/>
      </xsl:call-template>  
    </xsl:if>

    <xsl:if test="$j &lt;= $col">
      <xsl:call-template name="createRows">
        <xsl:with-param name="col" select="$col"/>
        <xsl:with-param name="j" select="$j + 1"/>
        <xsl:with-param name="i" select="$i"/>
      </xsl:call-template>
    </xsl:if>
</xsl:template>
  
  <xsl:template name="createCols">
    <!--method to create table col-->
    <xsl:param name="j"/>
    <xsl:param name="i"/>

    <td class="month">

    <xsl:variable name="currentDay">
    <xsl:call-template name="getDay">
      <xsl:call-template name="getFirstDayOfMonth">
        <xsl:with-param name="date" select="$date"/>
      </xsl:call-template>
    </xsl:call-template>  
    </xsl:variable>

    <xsl:call-template name="insertMonth">
      <xsl:with-param name="day" select="($j) mod 7"/>
      <xsl:with-param name="i" select="$i"/>
    </xsl:call-template>
    
    </td>

  </xsl:template>

  <xsl:template name="getTimeValue">
    <xsl:param name="time"/>

    <xsl:variable name="hour" select="substring-before($time,':')"/>
    <xsl:variable name="minutes" select="substring-after($time,':')"/>

    <xsl:value-of select="$hour * 4.16 + $minutes * 0.0694"/>
  </xsl:template>

  <xsl:template name="DrawBackgroundLinesAndHeadDate">
    <xsl:param name="iterationtimes"/>
    <xsl:param name="date"/>
    <th>
    <!--Insert Dates for header here-->
      <xsl:value-of select="concat(concat(substring-before($date, '.'), '.'), substring-before(substring-after($date, '.'), '.'))"/>
    </th>
    <xsl:if test="$iterationtimes > 0">
      <xsl:variable name="nextdate">
        <xsl:call-template name="next-day-date">
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="DrawBackgroundLinesAndHeadDate">
        <xsl:with-param name="iterationtimes" select="$iterationtimes -1"/>
        <xsl:with-param name="date" select="$nextdate"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="erliestStart">
    <xsl:param name="path"/>
    
    <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
      <xsl:sort order="ascending" select="substring-after(substring-after(startDate/@val | duedate/@val,'.'),'.')" data-type="number"/>
      <xsl:sort order="ascending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
      <xsl:sort order="ascending" select="substring-before(startDate/@val | duedate/@val, '.')"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="startDate/@val | duedate/@val"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>


  <xsl:template name="latestEnd">
    <xsl:param name="path"/>
    <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
      <xsl:sort order="descending" select="substring-after(substring-after(startDate/@val | duedate/@val,'.'),'.')" data-type="number"/>
      <xsl:sort order="descending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
      <xsl:sort order="descending" select="substring-before(startDate/@val | duedate/@val, '.')"/>
      
      <xsl:if test="position() = 1">
        <xsl:value-of select="startDate/@val | duedate/@val"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="DrawDivsInLines">
    <xsl:param name="path"/>
    <xsl:param name="startJulian"/>
    <xsl:param name="endJulian"/>
    <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
      <xsl:sort order="ascending" select="substring-after(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
      <xsl:sort order="ascending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
      <xsl:sort order="ascending" select="substring-before(startDate/@val | duedate/@val, '.')" data-type="number"/>
      <xsl:variable name="startDate">
        <xsl:call-template name="calculateJulianDay">
          <xsl:with-param name="date" select="startDate/@val | duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="endDate">
        <xsl:call-template name="calculateJulianDay">
          <xsl:with-param name="date" select="endDate/@val | duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>
      <tr>
        <xsl:call-template name="drawDivsInOneLine">
          <xsl:with-param name="length" select="$endDate - $startDate"/>
          <xsl:with-param name="name" select="name/@val"/>
          <xsl:with-param name="startJulian" select="$startJulian"/>
          <xsl:with-param name="endJulian" select="$endJulian"/>
        </xsl:call-template>
      </tr>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="drawDivsInOneLine">
    <xsl:param name="length"/>
    <xsl:param name="name"/>
    <xsl:param name="startJulian"/>
    <xsl:param name="endJulian"/>
      <xsl:variable name="startDivJulian">
        <xsl:call-template name="calculateJulianDay">
          <xsl:with-param name="date" select="startDate/@val | duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="offsetToBeginnig">
        <xsl:value-of select="$startDivJulian - $startJulian"/>
      </xsl:variable>
      <xsl:call-template name="insertEmptyTD">
        <xsl:with-param name ="TDCount" select="$offsetToBeginnig"></xsl:with-param>
      </xsl:call-template>
      <td>
        <xsl:variable name="type" select="name()"></xsl:variable>
          <xsl:attribute name="class" >
            <xsl:value-of select="$type"></xsl:value-of>
              <xsl:text > elementTD</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="colspan" >
            <xsl:value-of select="$length+1"></xsl:value-of>
          </xsl:attribute>
          <a href="calendar.xml" target="popup" onclick="window.open('calendar.xml','popup','width=600,height=600'); return false;">
            <xsl:value-of select="$name"></xsl:value-of>
          </a>
      </td>
      <xsl:call-template name="insertEmptyTD">
        <xsl:with-param name ="TDCount" select="$endJulian - $startDivJulian - $length"></xsl:with-param>
      </xsl:call-template>
  </xsl:template>

  <xsl:template name="insertEmptyTD">
    <xsl:param name="TDCount"/>
      <xsl:if test="$TDCount > 0">
        <td>
        </td>
        <xsl:call-template name="insertEmptyTD">
          <xsl:with-param name="TDCount" select="$TDCount -1"/>
        </xsl:call-template>
      </xsl:if>
  </xsl:template>

  <xsl:template name="next-day-date">
    <xsl:param name="date"/>
    <xsl:variable name="old_year" select="substring-after(substring-after($date,'.'),'.')"/>
    <xsl:variable name="old_month" select="substring-before(substring-after($date,'.'),'.')"/>
    <xsl:variable name="old_day" select="substring-before($date,'.')"/>
    <xsl:variable name="year">
      <xsl:choose>
        <xsl:when test="$old_month='12' and $old_day='31'">
          <xsl:value-of select="$old_year+1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$old_year"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="month">
      <xsl:choose>
        <xsl:when test="$old_day='31'">
          <xsl:choose>
            <xsl:when test="$old_month=1 or $old_month=3 or $old_month=5 or $old_month=7 or $old_month=8">
              <xsl:text>0</xsl:text>
              <xsl:value-of select="$old_month+1"/>
            </xsl:when>
            <!-- october -->
            <xsl:when test="$old_month='10'">
              <xsl:value-of select="$old_month+1"/>
            </xsl:when>
            <!-- december it is -->
            <xsl:when test="$old_month='12'">
              <xsl:text>01</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$old_month"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$old_day='30'">
          <xsl:choose>
            <xsl:when test="$old_month=4 or $old_month=6 or $old_month=9">
              <xsl:if test="$old_month!=9">
                <xsl:text>0</xsl:text>
              </xsl:if>
              <xsl:value-of select="$old_month+1"/>
            </xsl:when>
            <!-- november -->
            <xsl:when test="$old_month='11'">
              <xsl:value-of select="$old_month+1"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$old_month"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$old_day='28' and $old_month=2">
          <xsl:text>03</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="string-length($old_month)=1">
              <xsl:value-of select="concat(0,$old_month)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$old_month"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="day">
      <xsl:choose>
        <xsl:when test="number($old_month)!=number($month)">
          <xsl:text>01</xsl:text>
        </xsl:when>
        <xsl:when test="number($old_day) &lt; 9">
          <xsl:text>0</xsl:text>
          <xsl:value-of select="$old_day+1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$old_day+1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$day"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="$month"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="$year"/>
  </xsl:template>
</xsl:stylesheet>