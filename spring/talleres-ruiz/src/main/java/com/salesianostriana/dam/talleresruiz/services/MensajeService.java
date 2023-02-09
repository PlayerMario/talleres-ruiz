package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.repositories.MensajeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MensajeService {

    private final MensajeRepository repository;

}
