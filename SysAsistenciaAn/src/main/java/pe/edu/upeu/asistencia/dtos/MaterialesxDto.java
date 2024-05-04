package pe.edu.upeu.asistencia.dtos;


import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import pe.edu.upeu.asistencia.models.Actividad;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MaterialesxDto {
    private Long id;
    private String cui;  
    private String tipoCui; 
    private String materEntre;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate fecha;  
    @JsonFormat(pattern = "HH:mm:ss")
    private LocalTime horaReg;  
    private String latituda;
    private String longituda; 
    @JsonFormat(pattern = "yyyy-MM-dd") 
    private LocalDate modFh;   
    private String offlinex;  
    @JsonIgnoreProperties({"asistenciaxs", "inscritos", "subactasisxs","materialesxs"})
    private Actividad actividadId;     
    
    public record MaterialesxCrearDto (Long id, String cui, String tipoCui, String materEntre, LocalDate fecha, 
    LocalTime horaReg, String latituda, String longituda, LocalDate modFh, String offlinex, Long actividadId) { }    
}
