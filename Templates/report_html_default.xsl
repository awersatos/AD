<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version = '2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:template match="report">
	<html>
	<head>
	<style type="text/css">
		h1, h2, h3, h4, h5, h6 { 
			font-family : sans-serif;
			color : white;
			background-color : #21489e;
			padding: 0.3em;
		}
		body { 
			font-family : verdana;
		}
		td, th {  
			padding: 0.5em;
			text-align : center;
			width : 18%;	
		}
		th { 
			background-color : #A6CAF0;
		
		}
		th.column1, td.column1 { 
			text-align: left;
			width : auto; 
		}
		table { 
			width : 100%; 
		}
		.front_matter, .front_matter_column1, .front_matter_column2, .front_matter_column3 {
			padding-top : 0.1em;
			padding-bottom : 0.1em;
			border : 0px solid black;
			width : auto;
			vertical-align: top
		}
		.front_matter_column1 {
			text-align : right;
		}
		.total_column1, .total_column {
			font-weight : bold;	
		}
		.total_column1 {
			text-align : right;
		}
		.front_matter_column2 {
			text-align : center;
		}
		.front_matter_column3 {
			text-align : left;
		}
		.warning, .error { 
			color : red;
			font-weight : bold;
		}	
		tr.onmouseout_odd { 
			background-color : #EEEEE0 
		}
		tr.onmouseout_even { 
			background-color : #F3F3E3   
		}
		tr.onmouseover_odd, tr.onmouseover_even { 
			background-color : lightYellow 
		} 
		a:link, a:visited, .q a:link,.q a:active,.q {
			color: #21489e; 
		}
		a:link.callback, a:visited.callback { 
			color: #008000 
		}
		a:link.customize, a:visited.customize {
			color: #C0C0C0;
			position: absolute; 
			right: 10px;
		}	
		p.contents_level1 {
			font-weight : bold;
			font-size : 110%;
			margin : 0.5em;
		}
		p.contents_level2 {
			position : relative;
			left : 20px;
			margin : 0.5em;
		}
	</style>
	<script type="text/javascript">
		function coordToMils(coord) {
			var number = coord / 10000;
			
			if (number != number.toFixed(3))
				number = number.toFixed(3);
			
			return number + 'mil'
		}

		function coordToMM(coord) {
			var number = 0.0254 * coord / 10000;
			
			if (number != number.toFixed(4))
				number = number.toFixed(4);
			
			return number + 'mm'
		}
	
		function convertCoord(coordNode, units) {
			for (var i = 0; i &lt; coordNode.childNodes.length; i++) {
				coordNode.removeChild(coordNode.childNodes[i]);		
			}

			var coord = coordNode.getAttribute('value');
			if (coord != null) {
				if (units == 'mm') {	
					textNode = document.createTextNode(coordToMM(coord));
					coordNode.appendChild(textNode);
				} else if (units == 'mil') {
					textNode = document.createTextNode(coordToMils(coord));		
					coordNode.appendChild(textNode);	
				}
			}
		}
	
		function convertUnits(unitNode, units) {
			for (var i = 0; i &lt; unitNode.childNodes.length; i++) {
				unitNode.removeChild(unitNode.childNodes[i]);		
			}
		
			textNode = document.createTextNode(units); 
			unitNode.appendChild(textNode);
		}
	
		function changeUnits(radio_input, units) {
			if (radio_input.checked) {
			
				var elements = document.getElementsByName('coordinate');
				if (elements) {
					for (var i = 0; i &lt; elements.length; i++) {
						convertCoord(elements[i], units);
					}
				}
	
				var elements = document.getElementsByName('units');
				if (elements) {
					for (var i = 0; i &lt; elements.length; i++) {
						convertUnits(elements[i], units);
					}
				}
			}
		}	
	</script>
<title><xsl:apply-templates select="title"/></title>
	</head>
	<body onload="">
		<xsl:if test="/report//coordinate">
			<xsl:attribute name="onload">
				<xsl:choose>
					<xsl:when test="//units/@default = 'mm'">document.getElementById('radio_mm').click()</xsl:when>
					<xsl:otherwise>document.getElementById('radio_mil').click()</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
	
		<xsl:call-template name="process_body"/>
	</body>
	</html>
</xsl:template>


<xsl:template name="process_body">
	<img ALT="Altium">
		<xsl:attribute name="src">
			file://<xsl:value-of select="//resource_path"/>AD-rgb_logo_223x64.gif
		</xsl:attribute>
	</img> 
	
	<xsl:variable name="url">dxpprocess://Client:SetupPreferences?Server=PCB|PageName=Reports</xsl:variable>
	<xsl:element name="a">
		<xsl:attribute name="href"><xsl:value-of select="$url"/></xsl:attribute>
		<xsl:attribute name="class">customize</xsl:attribute>
		<acronym><xsl:attribute name="title"><xsl:value-of select="$url"/></xsl:attribute>customize</acronym>		
	</xsl:element>

	<h1><xsl:apply-templates select="title"/></h1>
	
	<table class="front_matter">
		<xsl:if test="date">		
			<tr class="front_matter">
				<td class="front_matter_column1">Date</td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3"><xsl:apply-templates select="date"/></td>
			</tr>
		</xsl:if>
	
		<xsl:if test="time">
			<tr class="front_matter">
				<td class="front_matter_column1">Time</td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3"><xsl:apply-templates select="time"/></td>
			</tr>
		</xsl:if>
		
		<xsl:if test="elapsed_time">
			<tr class="front_matter">
				<td class="front_matter_column1">Elapsed Time</td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3"><xsl:apply-templates select="elapsed_time"/></td>
			</tr>
		</xsl:if>
	
		<xsl:if test="filename">
			<tr class="front_matter">
				<td class="front_matter_column1">Filename</td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3"><xsl:apply-templates select="filename"/></td>
			</tr>
		</xsl:if>
		
		<xsl:if test="/report//coordinate">
			<tr class="front_matter">
				<td class="front_matter_column1">Units</td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3">
					<form>
						<input type="radio" name="radio_units" id="radio_mm" onclick="changeUnits(this, 'mm')"/>mm<!--br/-->
						<input type="radio" name="radio_units" id="radio_mil" onclick="changeUnits(this, 'mil')"/>mils<!--br/-->
					</form>
				</td>
			</tr>
		</xsl:if>
		
		<xsl:for-each select="/report/frontmatter">
			<tr class="front_matter">
				<td class="front_matter_column1"><xsl:apply-templates select="name"/></td>
				<td class="front_matter_column2">:</td>
				<td class="front_matter_column3"><xsl:apply-templates select="*[not(name()='name')]"/></td>
			</tr>
		</xsl:for-each>
	</table>
		
	<xsl:apply-templates select="error"/>

	<hr/>

	<xsl:apply-templates select="section"/>

	<xsl:apply-templates select="*[not(name()='title') and 
								   not(name()='error') and 
								   not(name()='filename') and 
								   not(name()='date') and 
								   not(name()='time') and 
								   not(name()='elapsed_time') and
								   not(name()='section') and
								   not(name()='resource_path') and
								   not(name()='frontmatter')]"/>
</xsl:template>

<xsl:template match="file">
	<xsl:element name="a">
		<xsl:attribute name="href">file:///<xsl:value-of select="@filename"/></xsl:attribute>
		<xsl:attribute name="class">file</xsl:attribute>
		<acronym>
			<xsl:attribute name="title"><xsl:value-of select="@filename"/></xsl:attribute>
			<xsl:apply-templates select="text()|*"/>
		</acronym>
	</xsl:element>
</xsl:template>

<xsl:template match="callback">
	<xsl:variable name="url">dxpprocess://<xsl:value-of select="@process"/>?<xsl:if test="@document">document=<xsl:value-of select="@document"/>;</xsl:if><xsl:if test="@viewname">viewname=<xsl:value-of select="@viewname"/>;</xsl:if><xsl:value-of select="@parameters"/></xsl:variable>
	<xsl:element name="a">
		<xsl:attribute name="href"><xsl:value-of select="$url"/></xsl:attribute>
		<xsl:attribute name="class">callback</xsl:attribute>
		<acronym>
			<xsl:attribute name="title"><xsl:value-of select="$url"/></xsl:attribute>
			<xsl:apply-templates select="text()|*"/>
		</acronym>		
	</xsl:element>
</xsl:template>

<xsl:template match="hyperlink">
		<xsl:variable name="url"><xsl:value-of select="@address"/></xsl:variable>			
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="$url"/>
			</xsl:attribute>			
   		   <xsl:if test="@open_In_New_Window &gt; '0' ">
			   <xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if> 
			<xsl:attribute name="class">callback</xsl:attribute>
			<acronym>
				<xsl:attribute name="title">
					<xsl:value-of select="$url"/>
				</xsl:attribute>
				<xsl:value-of select="@description"/>
			</acronym>
		</xsl:element>
</xsl:template>

<xsl:template match="list">
	<ul>
		<xsl:apply-templates select="*"/>	
	</ul>
</xsl:template>

<xsl:template match="space"><xsl:text disable-output-escaping="yes"> &amp;nbsp;</xsl:text></xsl:template>

<xsl:template match="listelement">
	<li>
		<xsl:apply-templates select="*"/>	
	</li>
</xsl:template>

<xsl:template match="report/error">
	<p class="error">ERROR : <xsl:apply-templates select="text()"/></p>
</xsl:template>

<xsl:template match="linebreak">
	<br/>
</xsl:template>

<xsl:template match="report/summary">
	<h2><xsl:apply-templates select="title"/></h2>

	<xsl:apply-templates select="summary_table"/>
	<hr/>
</xsl:template>

<xsl:template match="report/section">
	<xsl:if test="*[not(name()='title')]">
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<h2><xsl:apply-templates select="title"/></h2>
		</a>
		<xsl:apply-templates select="*[not(name()='title')]"/>
		<hr/>
	</xsl:if>
</xsl:template>

<xsl:template name="process_table_for_contents">
	<a>
		<xsl:attribute name="href">#<xsl:value-of select="generate-id(.)" /></xsl:attribute>
		<xsl:apply-templates select="title"/><br/>
	</a>
</xsl:template>

<xsl:template match="contents">		
		<xsl:for-each select="/report/section">
			<xsl:if test="*[not(name()='title')]">
				<p>
					<xsl:attribute name="class">contents_level1</xsl:attribute>
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="generate-id(.)"/></xsl:attribute>	
						<xsl:apply-templates select="title"/>
					</a>
				</p>
				
				<xsl:for-each select="table">
					<p>	
						<xsl:attribute name="class">contents_level2</xsl:attribute>
						<xsl:call-template name="process_table_for_contents"/>
					</p>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
		
		<xsl:if test="/report/table">
			<br/>
			<xsl:for-each select="/report/table">
				<p>	
					<xsl:attribute name="class">contents_level2</xsl:attribute>
					<xsl:call-template name="process_table_for_contents"/>
				</p>
			</xsl:for-each>			
		</xsl:if>
		<br/>
</xsl:template>

<xsl:template match="summary_table">
	<table>

	<tr>
	<xsl:element name="th">
		<xsl:attribute name="class">column1</xsl:attribute>
		<xsl:apply-templates select="title"/>
	</xsl:element>	
	
	<xsl:for-each select="columns/column">	
		<xsl:element name="th">
			<xsl:attribute name="class"><xsl:value-of select="concat('column',position() + 1)"/></xsl:attribute>
			<xsl:apply-templates select="text()"/>
		</xsl:element>
	</xsl:for-each>
	</tr>
	
	<xsl:for-each select="columns/column">
		<xsl:variable name="column_type" select="attribute::type"/>

		<xsl:for-each select="ancestor::report//table">
			<xsl:if test="type=$column_type">
		  		<xsl:element name="tr">  				
		  			<xsl:call-template name="classify_row_even_or_odd"/>		
				
					<xsl:element name="td">
						<xsl:call-template name="apply_column_index_attribute">
							<xsl:with-param name="index">1</xsl:with-param>
						</xsl:call-template>
						<xsl:element name="a">
							<xsl:attribute name="href">#<xsl:value-of select="generate-id(.)" /></xsl:attribute>
							<xsl:apply-templates select="title"/>
						</xsl:element>
					</xsl:element>
	
					<xsl:element name="td">
						<xsl:call-template name="apply_column_index_attribute">
							<xsl:with-param name="index">2</xsl:with-param>
						</xsl:call-template>
						<xsl:value-of select="count(row)"/>
					</xsl:element>
				
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		
	</xsl:for-each>
	
	<xsl:for-each select="columns/column">
		<xsl:variable name="column_type" select="attribute::type"/>
	
		<tr>
			<td style="font-weight : bold; text-align : right">
				<xsl:call-template name="apply_column_index_attribute">
					<xsl:with-param name="index">1</xsl:with-param>
				</xsl:call-template>Total</td>
			
			
			<td style="font-weight : bold">
				<xsl:call-template name="apply_column_index_attribute">
					<xsl:with-param name="index">2</xsl:with-param>
				</xsl:call-template>
						<xsl:value-of select="count(ancestor::report//table[type = $column_type]/row)"/></td>
		</tr>
	</xsl:for-each>
	
	
	</table>
	<br/>
	<!--hr/-->
</xsl:template>

<xsl:template match="html">
	<xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="table">
	<xsl:if test="not(@suppress_title)">
		<h2><xsl:value-of select="title"/></h2>
	</xsl:if>
		
	<xsl:if test="columns">
		<xsl:variable name="table_type"><xsl:value-of select="type"/></xsl:variable>

		<xsl:element name="a">
		<xsl:attribute name="name"><xsl:value-of select="generate-id(.)" /></xsl:attribute>
		<xsl:element name="table">		
		
	  			<xsl:element name="tr">
	  				
	  				<xsl:choose>
	  				<xsl:when test="columns/@use='title'">
			  			<xsl:element name="th">
			  				<xsl:attribute name="style">text-align : left</xsl:attribute>
			  				<xsl:attribute name="colspan">
			  					<xsl:value-of select="count(row[1]/cell)"/>
			  				</xsl:attribute>
							<xsl:if test="not($table_type) = ''">
								<xsl:attribute name="class"><xsl:value-of select="$table_type"/></xsl:attribute>			
							</xsl:if>	
							<xsl:value-of select="title"/>	  				
			  			</xsl:element>
		  			</xsl:when>
		  			<xsl:otherwise>
		  				<xsl:for-each select="columns/column" >
		  					<xsl:element name="th">						
		  						
		  						<xsl:attribute name="class">
									<xsl:value-of select="concat('column',position())"/>
								</xsl:attribute>
								
								<xsl:choose>
									<xsl:when test="position() = 1" >
										<xsl:apply-templates select="."/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="."/>	
									</xsl:otherwise>
								</xsl:choose>	  								  					
		  					</xsl:element>		  				
		  				</xsl:for-each>	  						  			
		  			</xsl:otherwise>
		  			</xsl:choose>
	  			</xsl:element>
	  			 			
	  			<xsl:for-each select="row">
	  				<xsl:call-template name="process_row"/>	  				
	  			</xsl:for-each>
		
		<xsl:if test="@numeric_totals and not(@numeric_totals='false') and not(columns/@use='title')">
	  		<tr>
	  			<td style="font-weight : bold; text-align : right" class="column1">Total</td>
	  			
	  			<xsl:for-each select="columns/column">  				
	  				<xsl:variable name="column_position" select="position()"/>

	  				<xsl:if test="not($column_position = 1)">
	  					<td style="font-weight : bold">
	  						<xsl:call-template name="apply_column_index_attribute"/>
		  					
		  					<xsl:if test="@data_type='number'">
		  						<xsl:value-of select="sum(ancestor::table/row/cell[$column_position])"/>
		  					</xsl:if>
	  					</td>
	  				</xsl:if> 			
	  			</xsl:for-each>
	  		</tr>
	  	</xsl:if>
	  	
		</xsl:element>
		</xsl:element>
	</xsl:if>

	<a href="#top">Back to top</a><br/><br/>
</xsl:template>

<xsl:template name="apply_column_index_attribute">
	<xsl:param name="index"><xsl:value-of select="position()"/></xsl:param>
	
	<xsl:attribute name="class">
		<xsl:value-of select="concat('column', $index)"/>
	</xsl:attribute>	
</xsl:template>

<xsl:template name="classify_row_even_or_odd">
	<xsl:param name="row_offset">0</xsl:param>
	
	<xsl:choose>
		<xsl:when test="(position() + $row_offset) mod 2 = 0">
			<xsl:attribute name="class">onmouseout_even</xsl:attribute>
			<xsl:attribute name="onmouseover">className = 'onmouseover_even'</xsl:attribute>
			<xsl:attribute name="onmouseout">className = 'onmouseout_even'</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="class">onmouseout_odd</xsl:attribute>
			<xsl:attribute name="onmouseover">className = 'onmouseover_odd'</xsl:attribute>
			<xsl:attribute name="onmouseout">className = 'onmouseout_odd'</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template match="coordinate">
	<!-- javascript is used to allow the coordinates to be converted to either mm or mil without reloading the document -->
	<a name="coordinate">
		<xsl:attribute name="value">
			<xsl:value-of select="text()"/>
		</xsl:attribute>
		
		<!-- if the browser prohibits or does not support javascript the following is displayed -->
		<xsl:choose>
			<xsl:when test="//units/@default = 'mm'">
				<xsl:value-of select="format-number(0.0254 * text() div 10000, '0.####')"/>mm
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number(text() div 10000, '0.###')"/>mils
			</xsl:otherwise>
		</xsl:choose>	
	</a>
</xsl:template>

<xsl:template name="process_row">
	<xsl:element name="tr">
		<xsl:call-template name="classify_row_even_or_odd"/>
							
		<xsl:for-each select="cell">
			<xsl:element name="td">
				<xsl:if test="@html_style">
					<xsl:attribute name="style"><xsl:value-of select="@html_style"/></xsl:attribute>		
				</xsl:if>
									
				<xsl:attribute name="class">
					<xsl:value-of select="concat('column',position())"/>
				</xsl:attribute>
							
				<xsl:apply-templates select="."/>
			</xsl:element>
		</xsl:for-each>
	</xsl:element>	
</xsl:template>

</xsl:stylesheet>
