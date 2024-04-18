<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:v1="http://mycompany.com/schemas/policy" xmlns:v2="http://mycompany.com/schemas/policy/v2">

    <xsl:template match="@xsi:schemaLocation">
    <xsl:attribute name="schemaLocation" namespace="xsi">http://mycompany.com/schemas/policy/v2 Policy_v2.xsd</xsl:attribute>
 <xsl:apply-templates select="@*|node()" />
  </xsl:template>



  <xsl:template match="v1:*">
    <xsl:element name="v2:{local-name()}">
      <xsl:apply-templates select="@*|node()" />
    </xsl:element>
  </xsl:template>
  


  <xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="v1:Policy">
  <v1:Policy>
      <xsl:apply-templates select="@*|node()" />  
      <v2:Census>Smith, John</v2:Census>
      </v1:Policy>
  </xsl:template>
  
  </xsl:stylesheet>