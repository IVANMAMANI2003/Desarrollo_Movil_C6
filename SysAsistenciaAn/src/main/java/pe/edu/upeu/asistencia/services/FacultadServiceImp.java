/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.upeu.asistencia.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pe.edu.upeu.asistencia.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistencia.models.Facultad;
import pe.edu.upeu.asistencia.repositories.FacultadRepository;

/**
 *
 * @author DELL
 */
@RequiredArgsConstructor
@Service
@Transactional
public class FacultadServiceImp implements FacultadService {

    @Autowired
    private FacultadRepository facultadRepo;

    @Override
    public Facultad save(Facultad facultad) {
        return facultadRepo.save(facultad);
    }

    @Override
    public List<Facultad> findAll() {
        return facultadRepo.findAll();
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Facultad facultadx = facultadRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Facultad not exist with id :" + id));
        facultadRepo.delete(facultadx);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;
    }

    @Override
    public Facultad getFacultadById(Long id) {
        Facultad findFacultad = facultadRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Facultad not exist with id :" + id));
        return findFacultad;
    }

    @Override
    public Facultad update(Facultad facultad, Long id) {
        Facultad facultadx = facultadRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        facultadx.setNombrefac(facultad.getNombrefac());
        facultadx.setEstado(facultad.getEstado());
        facultadx.setIniciales(facultad.getIniciales());
        return facultadRepo.save(facultadx);
    }

}
