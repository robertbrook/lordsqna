def load_spec_data
  @written_answers_title = %Q|<h3 align="center"><a name="08040381000002"></a>Written Answers</h3>|


  @date_text = %Q|3 Apr 2008|
  @date = %Q|<meta name="Date" content="#{@date_text}">|

  @major_title = %Q|Agriculture|
  @minor_title = %Q|Disease Testing|
  @title_text = "#{@major_title}: #{@minor_title}"

  @title = %Q|<a name="wa_subhd_0"></a>
    <a name="80403w0001.htm_sbhd0"></a>
    <h3 align="center"><a name="08040380000001"></a>#{@title_text}</h3>|

  @asked_hmgov = "asked Her Majesty's Government:"

  @asking_member = 'Lord Taylor of Holbeach'

  @question_css_name = %Q|wa_qn_0|
  @question_introduction = %Q|<p><a name="#{@question_css_name}"></a>
    <!--meta name="Colno" CONTENT="189"-->
    <a name="80403w0001.htm_wqn0"></a>
    <a name="08040380000044"></a>
    <b><a name="80403w0001.htm_spnew0"></a>
      <b><a name="80403w0001.htm_spnew1"></a>
      <a name="08040380000424"></a>#{@asking_member}</b><!--Lord Taylor of Holbeach--></b><!----> #{@asked_hmgov}</p>|

  @question_id = 'HL2876'

  @question_text = %Q|Why the Diseases of Animals (Approved Disinfectants) (Fees) Order 2008 (SI 2008/652) increased the fees for testing for use with foot and mouth disease and swine vesicular disease by 98.7 per cent, but by less than 3 per cent for use with all other types of disease. [#{@question_id}]|

  @question = %Q|
  <ul><a name="08040380000367"></a>
    <p><a name="wa_qnpa_0">#{@question_text}</a></p>
  </ul>|

  @answering_role = 'The Minister of State, Department for Environment, Food and Rural Affairs'
  @answering_member = 'Lord Rooker'
  @answering_name = %Q|#{@answering_role} (#{@answering_member})|

  @answer_initial_paragraph_text = %Q|It is government policy that regulatory and approval regimes should be cost-neutral and that regulatory bodies charge appropriate fees.|
  @answer_2nd_paragraph_text = %Q|Prior to the revision of fees in 2005, no fees relating to the approval mechanism had been revised since 1991. It was proposed that the fees Order would be revised to start to recover the fees for testing. Since 2005, the price for each of the tests charged by the Veterinary Laboratories Agency has been revised and is based on the actual hours needed to perform the test by graded staff, together with the materials used: that is, the full economic cost. The prices reflect the complexity of the tests and difficulty of the methodologies.|
  @answer_3rd_paragraph_text = %Q|The Institute for Animal Health (IAH) is the only laboratory in the UK equipped to undertake efficacy testing of disinfectants against foot and mouth disease and swine vesicular disease testing. The IAH is also now required to recover the full economic cost of the testing service they provide. This has resulted in them needing to revise their fees, something they have not needed to do since 2005.|

  @answer_initial_paragraph = %Q|<p><a name="wa_st_0"></a>
    <!--meta name="Colno" CONTENT="189"-->
    <a name="08040380000045"></a>
    <b><a name="80403w0001.htm_spmin0"></a>
      <b><a name="80403w0001.htm_spmin1"></a>
      <a name="08040380000425"></a>#{@answering_name}:</b>
      <!--Lord Rooker--></b>
        <!----> #{@answer_initial_paragraph_text}</p>|
  @answer_2nd_paragraph = %Q|<a name="80403w0001.htm_para0"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
    <p><a name="wa_stpa_0"></a><a name="08040380000046"></a>#{@answer_2nd_paragraph_text}</p>|
  @answer_3rd_paragraph = %Q|<a name="80403w0001.htm_para1"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
    <p><a name="wa_stpa_1"></a><a name="08040380000047"></a>#{@answer_3rd_paragraph_text}</p>|


  @second_asking_member = %Q|Lord Taylor of Holbeach|

  @second_question_css_name = %Q|wa_qn_1|
  @second_question_introduction = %Q|<p><a name="#{@second_question_css_name}"></a>
    <!--meta name="Colno" CONTENT="189"-->
    <a name="80403w0001.htm_wqn1"></a>
    <a name="08040380000048"></a>
    <b><a name="80403w0001.htm_spnew2"></a><b>
    <a name="80403w0001.htm_spnew3"></a>
    <a name="08040380000426"></a>#{@second_asking_member}</b><!--Lord Taylor of Holbeach--></b><!----> #{@asked_hmgov}</p>|

  @second_question_id = 'HL2877'

  @second_question_text = %Q|Why the Diseases of Animals (Approved Disinfectants) (Fees) Order 2008 (SI 2008/652) increased the fee for administrative services in connection with testing from £134 to £1,650. [#{@second_question_id}]|

  @second_question = %Q|
    <ul><a name="08040380000368"></a>
      <p><a name="wa_qnpa_1"></a>#{@second_question_text}</p>
    </ul>|

  @second_answering_member = 'Lord Rooker'
  @second_answer_initial_paragraph_text = %Q|It is government policy that regulatory and approval regimes are cost-neutral and that regulatory bodies charge appropriate fees. It is not considered appropriate for Defra and the taxpayer to subsidise the mechanism when manufacturers in industry benefit from the sale of their products.|
  @second_answer_2nd_paragraph_text = %Q|Prior to the revision of fees in 2005, no fees relating to the approval mechanism had been revised since 1991. This had resulted in a growing disparity between what Defra was allowed to charge under the Order and the actual costs incurred.|
  @second_answer_3rd_paragraph_text = %Q|In 2004, industry were informed of the proposal that the fees would be revised to start to recover the costs for testing and that fees would be revised to recover the administrative cost later. Defra did not increase the administrative fee for the approval mechanism when testing fees were reviewed. This was because a fundamental overhaul of the approval process was planned and is now complete.|

  @second_answer_initial_paragraph = %Q|<p>
    <a name="wa_st_1"></a>
    <!--meta name="Colno" CONTENT="189"-->
    <a name="08040380000049"></a>
    <b><a name="80403w0001.htm_spnew4"></a><b>
    <a name="80403w0001.htm_spnew5"></a>
    <a name="08040380000427"></a>#{@second_answering_member}:</b><!--Lord Rooker--></b><!----> #{@second_answer_initial_paragraph_text}</p>|

  @second_answer_2nd_paragraph = %Q|<a name="80403w0001.htm_para2"></a>
    <!--meta name="Speaker" CONTENT="Lord Rooker"-->
    <p><a name="wa_stpa_2"></a><a name="08040380000050"></a>#{@second_answer_2nd_paragraph_text}</p>|

  @column_break = %Q|<notus-date day="3" month="4" year="2008" textmonth="Apr"></notus-date>
    <columnnum><br> <br>
    <a name="column_WA190"></a>
    <b>3 Apr 2008 : Column WA190</b><br> <br></columnnum>|

  @second_answer_3rd_paragraph = %Q|<a name="80403w0001.htm_para3"></a>
    <!--meta name="Speaker" CONTENT="Lord Rooker"-->
    <p><a name="wa_stpa_3"></a><a name="08040380000051"></a>#{@second_answer_3rd_paragraph_text}</p>|

  @alternate_question_introduction = %Q|<p><a name="wa_st_15"></a>
    <!--meta name="Colno" CONTENT="194"-->
    <a name="08040380000084"></a>
    <b><a name="80403w0001.htm_spnew42"></a><b>
    <a name="80403w0001.htm_spnew43"></a>
    <a name="08040380000454"></a>Lord Harris of Haringey</b><!--Lord Harris of Haringey--></b><!----> asked the Chairman of Committees:</p>|

  @text_before_col_break = 'In the last year, neither the Parliamentary Network nor parliamentary applications or servers that are'
  @text_after_col_break = 'fully managed by PICT have been adversely affected by any malicious programmes. Any viruses detected are quarantined or removed by anti-virus software. Since January there have been 79 instances logged when single machines appeared to have been infected by malware but these incidents were contained on the individual machine. The malware was removed as soon as practicably possible.'
  @answer_paragraph_containing_column_break = %Q|<p><a name="wa_st_16"></a>
<!--meta name="Colno" CONTENT="194"--><a name="08040380000085"></a><b><a name="80403w0001.htm_spmin18"></a><b><a name="80403w0001.htm_spmin19"></a><a name="08040380000455"></a>The Chairman of Committees (Lord Brabazon of Tara):</b><!--Lord Brabazon of Tara--></b><!----> #{@text_before_col_break}
<notus-date day="3" month="4" year="2008" textmonth="Apr"></notus-date><columnnum><br> <br><a name="column_WA195"></a><b>3 Apr 2008 : Column WA195</b><br> <br></columnnum>#{@text_after_col_break}</p>|

  @question1_id = %Q|HL2711|
  @question2_id = %Q|HL2712|
  @question1_text = %Q|How much government funding is being allocated to the development of second-generation biofuels, including cellulosic ethanol, biobutanol and synthetic fuels from biomass; and [#{@question1_id}]|
  @question2_text = %Q|Which biofuel research projects are receiving government funding. [#{@question2_id}]|
  @two_questions = %Q|<ul><a name="08040269000202"></a>
    <p><a name="wa_qnpa_16"></a>#{@question1_text}</p>
    </ul>
    <ul><a name="08040269000203"></a>
      <p><a name="wa_qnpa_17"></a>#{@question2_text}</p>
    </ul>|
end
