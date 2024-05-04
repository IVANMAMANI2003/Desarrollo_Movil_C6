package pe.edu.upeu.asistencia.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistencia.dtos.MaterialesxDto;
import pe.edu.upeu.asistencia.models.Materialesx;

/**
 *
 * @author DELL
 */
public interface MaterialesxService {
    Materialesx save(MaterialesxDto.MaterialesxCrearDto materialesx);

    List<Materialesx> findAll();

    Map<String, Boolean> delete(Long id);

    Materialesx getMaterialesxById(Long id);

    Materialesx update(MaterialesxDto.MaterialesxCrearDto materialesx, Long id);
}
