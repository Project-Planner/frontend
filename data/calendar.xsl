<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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
          <td id="leftBorder">Hallo</td>
          <td>Hallo</td>
          <td>Hallo</td>
          <td>Hallo</td>
          <td>Hallo</td>
          <td>Hallo</td>
          <td id="rightBorder">Hallo</td>
          </tr>
        </tbody>
    </table>
  </div>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>

          <!-- <xsl:for-each select="calendar/items/appointments/appointment">
            <td>
              <div>
                  <p class="appointment"><xsl:value-of select="name/@val"/></p>
              </div>
            </td>
          </xsl:for-each> -->