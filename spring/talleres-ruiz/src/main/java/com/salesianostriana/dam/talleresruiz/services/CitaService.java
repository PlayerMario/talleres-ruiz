package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CitaService {

    private final CitaRepository repository;

    public List<Cita> findAll() {
        List<Cita> result = repository.findAll();
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen citas");
        }
        return result;
    }

    public void setearNullMecanico(Mecanico mecanico) {
        repository.findByMecanico(mecanico).forEach(cita -> {
            cita.setMecanico(null);
        });
    }

}
