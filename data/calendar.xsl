<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
  <html>
    <head>
      <link rel="stylesheet" href="../css/CalendarView.css"/>
    </head>
  <body>

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
          <tr>
              <xsl:for-each select="calendar/items/milestones/milestone">
            <td>
              <div class="daydiv">
                <p>1</p>
                  <milestone><xsl:value-of select="name/@val"/></milestone>
                  <br/>
                  <appointment><xsl:value-of select="//calendar/items/appointments/appointment/name/@val"/></appointment>

              </div>
            </td>
          </xsl:for-each>
          </tr>
        </tbody>
    </table>



  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
