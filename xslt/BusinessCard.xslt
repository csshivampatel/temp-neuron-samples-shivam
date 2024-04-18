<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/1999/xhtml">
 
   <xsl:template match="card[@type='simple']">
     <html xmlns="http://www.w3.org/1999/xhtml">
       <title>business card</title><body>
         <xsl:apply-templates select="name" />
         <xsl:apply-templates select="title" />
         <xsl:apply-templates select="email" />
         <xsl:apply-templates select="phone" />
     </body></html>
   </xsl:template>
 
   <xsl:template match="card/name">
     <h1><xsl:value-of select="text()" /></h1>
   </xsl:template>
 
   <xsl:template match="email">
     <p>email: <a href="mailto:{text()}"><tt>
       <xsl:value-of select="text()" />
     </tt></a></p>
   </xsl:template> 

 </xsl:stylesheet>