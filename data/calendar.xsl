<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="calendarID" select="calendar/id/@val"/>
  <xsl:variable name="period" select="'day'"/>
  <xsl:variable name="date" select="'1.6.2021'"/>
  <xsl:template match="/">
    <html>
    <script src="/js/editItem.js"></script>
      <head>
        <link rel="stylesheet" href="/css/calendarView.css"/>
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
        <div id ="EditItemView">
        <iframe class="editItem" id="editItem" name="editItem"  src="/html/createEntry.html"></iframe>
      </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="dayCalendar">
    <!--This method generates the day based Calendar-->
    <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
    </xsl:variable>

  <div class="background">

    <div class="tableDay"> 
        <table>
        <caption class="caption">
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
        </caption>
          <thead class="bl">
            <tr>
              <th>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>00:00 Uhr</td>
              <td rowspan="24" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'00:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>01:00 Uhr</td>
              <td rowspan="23" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'01:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>02:00 Uhr</td>
              <td rowspan="22" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'02:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>03:00 Uhr</td>
              <td rowspan="21" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'03:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>04:00 Uhr</td>
              <td rowspan="20" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'04:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>05:00 Uhr</td>
              <td rowspan="19" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'05:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>06:00 Uhr</td>
              <td rowspan="18" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'06:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>07:00 Uhr</td>
              <td rowspan="17" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'07:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>08:00 Uhr</td>
              <td rowspan="16" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'08:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>09:00 Uhr</td>
              <td rowspan="15" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'09:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>10:00 Uhr</td>
              <td rowspan="14" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'10:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>11:00 Uhr</td>
              <td rowspan="13" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'11:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>12:00 Uhr</td>
              <td rowspan="12" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'12:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>13:00 Uhr</td>
              <td rowspan="11" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'13:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>14:00 Uhr</td>
              <td rowspan="10" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'14:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
              <tr>
              <td>15:00 Uhr</td>
              <td rowspan="9" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'15:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>16:00 Uhr</td>
              <td rowspan="8" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'16:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>17:00 Uhr</td>
              <td rowspan="7" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'17:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>18:00 Uhr</td>
              <td rowspan="6" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'18:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>19:00 Uhr</td>
              <td rowspan="5" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'19:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>20:00 Uhr</td>
              <td rowspan="4" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'20:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>21:00 Uhr</td>
              <td rowspan="3" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'21:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>22:00 Uhr</td>
              <td rowspan="2" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'22:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td>23:00 Uhr</td>
              <td rowspan="1" class="anchor">
                <xsl:call-template name="insertDay">
                  <xsl:with-param name="tableVal" select="'23:00'"/>
                  <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

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
    <xsl:param name="tableVal"/>

    <!--Insert milestones-->
    <xsl:for-each select="calendar/items/milestones/milestone">
      <xsl:sort select="duetime/@val" data-type="number"/>
        <xsl:if test="duedate/@val=$date">
        
          <xsl:variable name="hourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="duetime/@val"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="tableHourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="$tableVal"/>
            </xsl:call-template>
          </xsl:variable>
        
          <xsl:if test="$tableHourVal = $hourVal">
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <xsl:attribute name="onclick">
              <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
            <div class="milestone dayEntry" style="{concat('margin-top:', $hourVal ,'%;')}">
              <p> <xsl:value-of select="name/@val"/> </p>
              <p> <xsl:value-of select="duedate/@val"/> </p>
            </div>
          </xsl:if>
        </xsl:if>
    </xsl:for-each>

    <!--Insert Tasks-->
    <xsl:for-each select="calendar/items/tasks/task">
      <xsl:sort select="startTime/@val" data-type="number"/>
        <xsl:if test="startDate/@val=$date">
      
          <xsl:variable name="hourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="startTime/@val"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="tableHourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="$tableVal"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="end">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="endTime/@val"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:if test="$tableHourVal = $hourVal">
          <xsl:variable name="id" select="@id"/>
          <xsl:variable name="apostrophe">'</xsl:variable>
          <div class="task dayEntry" style="{concat('margin-top:', $end - $hourVal,'%;')}">
          <xsl:attribute name="onclick">
            <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
          </xsl:attribute>
          <p> <xsl:value-of select="name/@val"/> </p>
          <p> <xsl:value-of select="startDate/@val"/> </p>
          </div>
          </xsl:if>

        </xsl:if>
    </xsl:for-each>

    <!--Insert Appointments-->
    <xsl:for-each select="calendar/items/appointments/appointment">
      <xsl:sort select="startTime/@val" data-type="number"/>
        <xsl:if test="startDate/@val=$date">
        
          <xsl:variable name="hourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="startTime/@val"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="tableHourVal">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="$tableVal"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="end">
            <xsl:call-template name="getHours">
              <xsl:with-param name="time" select="endTime/@val"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:if test="$tableHourVal = $hourVal">
          <xsl:variable name="id" select="@id"/>
          <xsl:variable name="apostrophe">'</xsl:variable>
          <div class="milestone dayEntry" style="{concat('margin-top:',  $end - $hourVal ,'%;')}">
          <xsl:attribute name="onclick">
            <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
          </xsl:attribute>
          <p> <xsl:value-of select="name/@val"/> </p>
          <p> <xsl:value-of select="startDate/@val"/> </p>
          </div>
          </xsl:if>
        </xsl:if>
    </xsl:for-each>
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
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="milestone">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
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
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="task">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="duedate/@val"/>
              </p>
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
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="appointment">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
              <p>
                <xsl:value-of select="startDate/@val"/>
              </p>
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
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="milestone">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
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
           <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="appointment">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
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
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="apostrophe">'</xsl:variable>
            <div class="task">
            <xsl:attribute name="onclick">
                <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
            </xsl:attribute>
              <p>
                <xsl:value-of select="name/@val"/>
              </p>
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

  <xsl:template name="getHours">
    <xsl:param name="time"/>
    <xsl:value-of select="substring-before($time,':')"/>
  </xsl:template>

</xsl:stylesheet>