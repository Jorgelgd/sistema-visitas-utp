package com.utp.visitas.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.OutputStream;
import java.util.List;
// Asegúrate de importar tu modelo, ej: com.utp.visitas.model.PromotorMetas
// import com.utp.visitas.model.PromotorMetas; 

public class ExportadorExcel {

    public static void generarReportePromotores(OutputStream out, List<Object> listaDatos) throws Exception {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Reporte Metas");

        // Estilo para encabezados
        CellStyle headerStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        headerStyle.setFont(font);

        // Crear encabezados
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Nombre Promotor");
        header.createCell(1).setCellValue("Meta Asignada");
        header.createCell(2).setCellValue("Colegios Auditados");
        header.createCell(3).setCellValue("Nivel de Avance");
        
        // Aplicar estilo a encabezados
        for(int i=0; i<4; i++) header.getCell(i).setCellStyle(headerStyle);

        // Llenar datos (Aquí ajustas según tu modelo real)
        int rowIdx = 1;
        for (Object item : listaDatos) {
            // Ejemplo: PromotorMetas p = (PromotorMetas) item;
            Row row = sheet.createRow(rowIdx++);
            // row.createCell(0).setCellValue(p.getNombre());
            // ... etc
        }

        workbook.write(out);
        workbook.close();
    }
}