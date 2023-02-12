package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.MensajeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MensajeService {

    private final MensajeRepository repository;

    public List<Mensaje> findAll() {
        List<Mensaje> result = repository.findAll();
        if (result.isEmpty()) {
            throw new EntityNotFoundException("No existen mensajes");
        }
        return result;
    }

    public void setearNullAutor(User user) {
        repository.findByAutor(user).forEach(mensaje -> {
            mensaje.setAutor(null);
        });
    }

}
