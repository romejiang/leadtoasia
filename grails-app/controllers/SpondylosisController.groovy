import java.awt.Color
import java.awt.Font
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.geom.Rectangle2D
import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import java.awt.geom.AffineTransform
import com.lucastex.grails.fileuploader.*

class SpondylosisController {

 
  def index = {
	return 
  }
  def process = {
    response.setContentType('image/png')
    response.setHeader('Cache-control', 'no-cache')

    // Generate and remember the Source Character string (6 characters)
  
    def text =  params.t.split(/\n/)  
    log.info text
	

    final int height = 1000
    final int width = 1000
    final int space = 20
    final int fontSize = 24

    System.setProperty('java.awt.headless', 'true')
    BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
    Graphics2D g2d = bufferedImage.createGraphics()
    Font font = new Font('Serif', Font.BOLD, fontSize)
    g2d.setFont(font)
    g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON)
    
    Rectangle2D fontRect = font.getStringBounds("中国", g2d.getFontRenderContext())
    // Now, create a graphic 'space' pixels wider and taller than the the font
    bufferedImage = new BufferedImage(width + space,
            height ,
            BufferedImage.TYPE_INT_RGB)
    g2d = bufferedImage.createGraphics()
    g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON)
    g2d.setFont(font)

    // Draw the background
    g2d.setColor(new Color(222,222,222))
    g2d.fillRect(0, 0, width, height)

 

    // Draw the String
    g2d.setColor(Color.black)
//    g2d.setColor(new Color(30,110,30))
// Rotate font
	  
	

//    g2d.drawString(b.toString(), (int) (space / 2), (int) fontRect.getHeight()  - (int)(fontSize /4 + 2))
 
//    g2d.drawString('中', 0, (int) fontRect.getHeight() )
//    g2d.drawString('国', 0 + 25, (int) fontRect.getHeight() + 10 )
	def count = 0
	 
	text.eachWithIndex{elem,i ->
		 
		g2d.setTransform(AffineTransform.getRotateInstance((i % 2 == 0?-100: 100) / 180));
		 
		count = 0
		elem.each{
			 count++
			 if (i % 2 == 0){
				g2d.drawString(it, 0 + count * 25 - i * 25 , 40 + i* 30 + count*15 )
			 }else{
				g2d.drawString(it, 0 + count * 25 + i * 35 , 40 + i * 1 - count * 15 )			 
			 }
		 }
	}

    OutputStream out = response.getOutputStream()
    ImageIO.write(bufferedImage, 'PNG', out)
    out.close()

   }

	def messageSource
  def test = { 
	
		UFile ufile = UFile.get(21)
		if (!ufile) {
			def msg = messageSource.getMessage("fileupload.download.nofile", [23] as Object[], request.locale)
			log.debug msg
			flash.message = msg
			redirect controller: params.errorController, action: params.errorAction
			return
		}
		
		def file = new File(ufile.path)
		if (file.exists()) {
			log.debug "Serving file id=[${ufile.id}] for the ${ufile.downloads} to ${request.remoteAddr}"
			ufile.downloads++
			ufile.save()
            params.contentDisposition = params.contentDisposition? params.contentDisposition: "attachment"
			response.setContentType("application/octet-stream;charset=UTF-8")
            response.setHeader("Pragma", "No-cache"); 
            response.setHeader("Cache-Control", "No-cache"); 
            response.setDateHeader("Expires", 0);
			response.setHeader("Content-disposition", "${params.contentDisposition}; filename=${new String(file.name.getBytes(),'iso8859-1')}") 
            response.setHeader("Content-Length", "${file.size()}");  

            BufferedInputStream bufferedInput = file.newInputStream() 
            BufferedOutputStream output = new BufferedOutputStream(response.outputStream);
            
            byte[] buffer = new byte[2048];
            int bytesRead = 0;
            while (-1 != (bytesRead = bufferedInput.read(buffer))) {
                output << buffer
            }
            response.flushBuffer()

            bufferedInput.close()
            output.close()
			return
		} else {
			def msg = messageSource.getMessage("fileupload.download.filenotfound", [ufile.name] as Object[], request.locale)
			log.error msg
			flash.message = msg
			redirect controller: params.errorController, action: params.errorAction
			return
		}
	}
}
