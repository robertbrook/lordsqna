require File.dirname(__FILE__) + '/../lib/answer'

describe Answer, 'when creating' do

  def H html
    Hpricot html
  end

  before :all do
    @written_answers_title = %Q|<h3 align="center"><a name="08040381000002"></a>Written Answers</h3>|
    @date = %Q|<h2 align="center">
        <a name="wa_date_0"></a>
        <a name="08040381000001"></a>
        <i>Thursday 3 April 2008</i></h2>|

    @title_text = 'Agriculture: Disease Testing'
    @title = %Q|<a name="wa_subhd_0"></a>
      <a name="80403w0001.htm_sbhd0"></a>
      <h3 align="center"><a name="08040380000001"></a>#{@title_text}</h3>|

    @asking_member = 'Lord Taylor of Holbeach'
    @questioner = %Q|<p><a name="wa_qn_0"></a>
      <!--meta name="Colno" CONTENT="189"-->
      <a name="80403w0001.htm_wqn0"></a>
      <a name="08040380000044"></a>
      <b><a name="80403w0001.htm_spnew0"></a>
        <b><a name="80403w0001.htm_spnew1"></a>
        <a name="08040380000424"></a>#{@asking_member}</b>
        <!--Lord Taylor of Holbeach--></b>
      <!----> asked Her Majesty's Government:</p>|

    @question_id = 'HL2876'
    @question_text = %Q|Why the Diseases of Animals (Approved Disinfectants) (Fees) Order 2008 (SI 2008/652) increased the fees for testing for use with foot and mouth disease and swine vesicular disease by 98.7 per cent, but by less than 3 per cent for use with all other types of disease. [#{@question_id}]|
    @question = %Q|
    <ul><a name="08040380000367"></a>
      <p><a name="wa_qnpa_0">#{@question_text}</a></p>
    </ul>|

    @answer_first_paragraph = %Q|<p><a name="wa_st_0"></a>
      <!--meta name="Colno" CONTENT="189"-->
      <a name="08040380000045"></a>
      <b><a name="80403w0001.htm_spmin0"></a>
        <b><a name="80403w0001.htm_spmin1"></a>
          <a name="08040380000425"></a>The Minister of State, Department for Environment, Food and Rural Affairs (Lord Rooker):</b>
        <!--Lord Rooker--></b>
      <!----> It is government policy that regulatory and approval regimes should be cost-neutral and that regulatory bodies charge appropriate fees.</p>|
    @answer_paragraph0 = %Q|<a name="80403w0001.htm_para0"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
<p><a name="wa_stpa_0"></a><a name="08040380000046"></a>Prior to the revision of fees in 2005, no fees relating to the approval mechanism had been revised since 1991. It was proposed that the fees Order would be revised to start to recover the fees for testing. Since 2005, the price for each of the tests charged by the Veterinary Laboratories Agency has been revised and is based on the actual hours needed to perform the test by graded staff, together with the materials used: that is, the full economic cost. The prices reflect the complexity of the tests and difficulty of the methodologies.</p>|
    @answer_paragraph1 = %Q|<a name="80403w0001.htm_para1"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
<p><a name="wa_stpa_1"></a><a name="08040380000047"></a>The Institute for Animal Health (IAH) is the only laboratory in the UK equipped to undertake efficacy testing of disinfectants against foot and mouth disease and swine vesicular disease testing. The IAH is also now required to recover the full economic cost of the testing service they provide. This has resulted in them needing to revise their fees, something they have not needed to do since 2005.</p>|
%Q|<p><a name="wa_qn_1"></a>
<!--meta name="Colno" CONTENT="189"--><a name="80403w0001.htm_wqn1"></a><a name="08040380000048"></a><b><a name="80403w0001.htm_spnew2"></a><b><a name="80403w0001.htm_spnew3"></a><a name="08040380000426"></a>Lord Taylor of Holbeach</b><!--Lord Taylor of Holbeach--></b><!----> asked Her Majesty's Government:</p>

<ul><a name="08040380000368"></a>
<p><a name="wa_qnpa_1"></a>Why the Diseases of Animals (Approved Disinfectants) (Fees) Order 2008 (SI 2008/652) increased the fee for administrative services in connection with testing from £134 to £1,650. [HL2877]</p>

</ul>

<p><a name="wa_st_1"></a>
<!--meta name="Colno" CONTENT="189"--><a name="08040380000049"></a><b><a name="80403w0001.htm_spnew4"></a><b><a name="80403w0001.htm_spnew5"></a><a name="08040380000427"></a>Lord Rooker:</b><!--Lord Rooker--></b><!----> It is government policy that regulatory and approval regimes are cost-neutral and that regulatory bodies charge appropriate fees. It is not considered appropriate for Defra and the taxpayer to subsidise the mechanism when manufacturers in industry benefit from the sale of their products.</p>

<a name="80403w0001.htm_para2"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
<p><a name="wa_stpa_2"></a><a name="08040380000050"></a>Prior to the revision of fees in 2005, no fees relating to the approval mechanism had been revised since 1991. This had resulted in a growing disparity between what Defra was allowed to charge under the Order and the actual costs incurred.</p>




<notus-date day="3" month="4" year="2008" textmonth="Apr"></notus-date><columnnum><br> <br><a name="column_WA190"></a><b>3 Apr 2008 : Column WA190</b><br> <br></columnnum>

<a name="80403w0001.htm_para3"></a><!--meta name="Speaker" CONTENT="Lord Rooker"-->
<p><a name="wa_stpa_3"></a><a name="08040380000051"></a>In 2004, industry were informed of the proposal that the fees would be revised to start to recover the costs for testing and that fees would be revised to recover the administrative cost later. Defra did not increase the administrative fee for the approval mechanism when testing fees were reviewed. This was because a fundamental overhaul of the approval process was planned and is now complete.</p>
|
  end

  it 'should find any answer title elements' do
    title_elements = Answer.find_title_elements H("<html>#{@written_answers_title}#{@date}#{@title}</html>")
    title_elements.size.should == 1
    title_elements.first.inner_text.to_s.should == @title_text
  end

  it 'should find title text' do
    heading = Answer.find_title_text H(@title)
    heading.should == @title_text
  end

  it 'should find asking member' do
    member = Answer.find_asking_member H(@title+@questioner).at('h3')
    member.should == @asking_member
  end

  it 'should find question text' do
    question = Answer.find_question_text H(@title+@questioner+@question).at('h3')
    question.should == @question_text
  end

  it 'should find question number' do
    id = Answer.find_question_id(@question_text)
    id.should == @question_id
  end

  it 'should create Answer instance from Hpricot document' do
    answers = Answer.from_doc H("<html>#{@title}#{@questioner}#{@question}</html>")
    answers.size.should == 1
    answer = answers.first
    answer.should be_an_instance_of(Answer)
    answer.title.should == @title_text
    answer.asking_member.should == @asking_member
    answer.question_id.should == @question_id
  end

  it 'should create Answer instance from url' do
    url = 'url'
    html = mock('html')
    doc = mock('doc')
    Answer.should_receive(:open).with(url).and_return html
    Answer.should_receive(:Hpricot).with(html).and_return doc
    Answer.should_receive(:from_doc).with(doc)
    Answer.from_url url
  end
end
