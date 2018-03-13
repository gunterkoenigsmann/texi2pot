<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="texifile">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="paragraph"><xsl:value-of select="."/></xsl:template>
</xsl:stylesheet>
