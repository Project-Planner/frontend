<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="weekDate" select="'1.1.1970'"/>
<xsl:variable name="displayMode" select="'calender'"/> <!--displayModes: calender/project-->
<xsl:variable name="calenderMode" select="'week'"/> <!--calenderModes: week/day/month-->
  
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="../css/calendarView.css"/>
      </head>
      <body>
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
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="1"/>
                  </xsl:call-template>
                </td>
                <td>
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="2"/>
                  </xsl:call-template>
                </td>
                <td>
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="3"/>
                  </xsl:call-template>
                </td>
                <td>
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="4"/>
                  </xsl:call-template>
                </td>
                <td>
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="5"/>
                  </xsl:call-template>
                </td>
                <td>
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="6"/>
                  </xsl:call-template>
                </td>
                <td id="rightBorder">
                  <xsl:call-template name="insert">
                    <xsl:with-param name="day" select="0"/>
                  </xsl:call-template>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="insert">
    <xsl:param name="day"/>
    <xsl:for-each select="calendar/items/milestones/milestone">
      <xsl:sort select="duedate/@val" data-type="number"/>
      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$dayOfDate=$day">
        <div>
          <p class="milestone">
            <xsl:value-of select="name/@val"/>
          </p>
        </div>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="calendar/items/tasks/task">
      <xsl:sort select="duedate/@val" data-type="number"/>
      <xsl:variable name="dayOfDate">
        <xsl:call-template name="getDay">
          <xsl:with-param name="date" select="duedate/@val"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$dayOfDate=$day">
        <div>
          <p class="task">
            <xsl:value-of select="name/@val"/>
          </p>
        </div>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="getDay">
    <xsl:param name="date"/>
    <xsl:param name="year" select="substring-before($date,'.')"/>
    <xsl:param name="month" select="substring-before(substring-after($date,'.'),'.')"/>
    <xsl:param name="day" select="substring-after(substring-after($date,'.'),'.')"/>

    <xsl:variable name="a" select="floor((14 - $month) div 12)"/>
    <xsl:variable name="y" select="$year - $a"/>
    <xsl:variable name="m" select="$month + 12 * $a - 2"/>

    <xsl:value-of select="($day + $y + floor($y div 4) - floor($y div 100) 
    + floor($y div 400) + floor((31 * $m) div 12)) mod 7"/>
  </xsl:template>
  
</xsl:stylesheet>