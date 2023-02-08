package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository repository;

}
