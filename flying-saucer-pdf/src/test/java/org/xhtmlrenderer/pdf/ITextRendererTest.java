package org.xhtmlrenderer.pdf;

import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.xhtmlrenderer.pdf.ITextRenderer;
import org.xhtmlrenderer.resource.FSEntityResolver;

import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfXConformanceException;

import junit.framework.TestCase;

public class ITextRendererTest extends TestCase {
	
	private static final String TEST_HTML_FILE = "simplePdfTemplate.html";
	private static final String TEST_COLOUR_PROFILE = "/testColourProfile.icm";
	private static final String COLOUR_ERROR_MSG = "Colour space profile has not been set";
	
	private ITextRenderer renderer;
	
	public void setUp() throws UnsupportedEncodingException {
		renderer = new ITextRenderer();
	}
	
	public void testCreateNonPdfAConformance() throws Exception {
		ByteArrayOutputStream outputStream = createPdf(TEST_HTML_FILE);
		assertNotNull(outputStream);
		assertTrue(outputStream.size() > 0);
	}
	
	public void testCreatePdfAConformanceNoFontsEmbedded() throws Exception {
		try {
			renderer.setPDFXConformance(PdfWriter.PDFX1A2001);
			renderer.setColourSpaceProfile(TEST_COLOUR_PROFILE);
			createPdf(TEST_HTML_FILE);
			fail();
		} catch(Exception e) {
			assertEquals(PdfXConformanceException.class, e.getClass());
		}
	}

	public void testCreatePdfAConformanceNoColourProfileSet() {
		try {
			renderer.setPDFXConformance(PdfWriter.PDFX1A2001);
			createPdf(TEST_HTML_FILE);
			fail();
		} catch (Exception e) {
			assertEquals(NullPointerException.class, e.getClass());
			assertEquals(COLOUR_ERROR_MSG, e.getMessage());
		}
	}
	
	private ByteArrayOutputStream createPdf(String htmlPath) throws Exception {
		URL htmlUrl = getClass().getResource(htmlPath);
		
		DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		builder.setEntityResolver(FSEntityResolver.instance());
		Document doc = builder.parse(htmlUrl.openStream());
		
		renderer.getSharedContext().setMedia("pdf");
		renderer.setDocument(doc, htmlUrl.toString());
		renderer.layout();
		
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		renderer.createPDF(outputStream);
		
		return outputStream;
	}
}
