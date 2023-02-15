package com.salesianostriana.dam.talleresruiz.services.user;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.OperacionDenegadaException;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
import com.salesianostriana.dam.talleresruiz.models.dto.user.security.UserPassword;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.UserRepository;
import com.salesianostriana.dam.talleresruiz.services.ficheros.FileSystemStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository repository;
    private final FileSystemStorageService storageService;


    public List<User> findAll() {
        return repository.findAll();
    }

    public Optional<User> findById(UUID id) {
        return repository.findById(id);
    }

    public User findByIdCheck(UUID id) {
        return repository.findById(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public User add(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return repository.save(user);
    }

    public User findByUsername(String username) throws UsernameNotFoundException {
        return repository.findFirstByUsername(username).orElseThrow(() ->
                new UsernameNotFoundException("No se encuentra al usuario: " + username));
    }

    public User findByDni(String dni) {
        return repository.findByDni(dni).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario"));
    }

    public boolean existsEmail(String email) {
        return repository.existsByEmail(email);
    }

    public boolean existsTlf(String tlf) {
        return repository.existsByTlf(tlf);
    }

    public boolean existsDNI(String dni) {
        return repository.existsByDni(dni);
    }

    public boolean existsUsername(String username) {
        return repository.existsByUsername(username);
    }

    public User editUser(UUID id, UserEdit edit) {
        return repository.findById(id)
                .map(user -> {
                    user.setNombre(edit.getNombre());
                    user.setEmail(edit.getEmail());
                    user.setTlf(edit.getTlf());
                    return repository.save(user);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public User editPassword(UUID id, UserPassword userPassword) {
        return repository.findById(id)
                .map(user -> {
                    if (passwordValidator(user, userPassword)) {
                        user.setPassword(passwordEncoder.encode(userPassword.getNewPassword()));
                        user.setLastPasswordChangeAt(LocalDateTime.now());
                    }
                    return repository.save(user);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public boolean passwordValidator(User user, UserPassword userPassword) {
        if (passwordEncoder.matches(userPassword.getNewPassword(), user.getPassword())) {
            throw new OperacionDenegadaException("La nueva contraseña no puede coincidir con la antigua");
        } else if (!passwordEncoder.matches(userPassword.getOldPassword(), user.getPassword())) {
            throw new OperacionDenegadaException("La antigua contraseña no coincide con la original");
        } else {
            return true;
        }
    }

    public UserDto generarUserDto(User usuario) {
        return repository.generarUserDto(usuario.getId());
    }

    public UserDto generarUserDtoToken(User usuario, String token) {
        UserDto userDto = repository.generarUserDto(usuario.getId());
        userDto.setToken(token);
        return userDto;
    }

    @Transactional
    public User cambiarAvatar(User usuario, MultipartFile fichero) {
        String nuevoAvatar = storageService.store(fichero);
        if (usuario.getAvatar().length() > 21
                && usuario.getAvatar().substring(0, 21).equalsIgnoreCase("https://robohash.org/")) {
            usuario.setAvatar(nuevoAvatar);
        } else {
            storageService.deleteFile(usuario.getAvatar());
            usuario.setAvatar(nuevoAvatar);
        }
        return repository.save(usuario);
    }

}
