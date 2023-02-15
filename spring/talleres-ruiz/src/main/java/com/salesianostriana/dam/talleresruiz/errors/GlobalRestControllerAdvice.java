package com.salesianostriana.dam.talleresruiz.errors;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.*;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiErrorImpl;
import com.salesianostriana.dam.talleresruiz.errors.models.impl.ApiValidationSubError;
import org.hibernate.validator.internal.engine.path.PathImpl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.persistence.EntityNotFoundException;
import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
        return buildApiError(ex.getMessage(), request, status);
    }

    // MANEJO ERRORES VALIDACIÓN
    @ExceptionHandler({EntityNotFoundException.class, BuscarFicheroException.class})
    public ResponseEntity<?> handleNotFoundException(EntityNotFoundException exception, WebRequest request) {
        return buildApiError(exception.getMessage(), request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({OperacionDenegadaException.class, StorageException.class})
    public ResponseEntity<?> handleSongPlaylistException(EntityNotFoundException exception, WebRequest request) {
        return buildApiError(exception.getMessage(), request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({ConstraintViolationException.class})
    public ResponseEntity<?> handleConstraintViolationException(ConstraintViolationException exception, WebRequest request) {
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(ApiErrorImpl.builder()
                        .status(HttpStatus.BAD_REQUEST)
                        .message("Error en la restricción de validación. Compruebe la lista.")
                        .path(((ServletWebRequest) request).getRequest().getRequestURI())
                        .subErrors(exception.getConstraintViolations().stream()
                                .map(v -> {
                                    return ApiValidationSubError.builder()
                                            .message(v.getMessage())
                                            .rejectedValue(v.getInvalidValue())
                                            .object(v.getRootBean().getClass().getSimpleName())
                                            .field(((PathImpl) v.getPropertyPath()).getLeafNode().asString())
                                            .build();
                                })
                                .collect(Collectors.toList())
                        )
                        .build()
                );
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        return buildApiErrorWithSubErrors("Error en la validación, compruebe la lista", request, status, ex.getAllErrors());
    }


    // MANEJO ERRORES TOKEN
    @ExceptionHandler({AuthenticationException.class, UsernameNotFoundException.class})
    public ResponseEntity<?> handleAuthenticationException(WebRequest request) {
        return buildApiError("Usuario y/o contraseña incorrecta", request, HttpStatus.UNAUTHORIZED);

    }

    @ExceptionHandler({AccessDeniedException.class})
    public ResponseEntity<?> handleAccessDeniedException(AccessDeniedException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.FORBIDDEN);

    }

    @ExceptionHandler({JwtTokenException.class})
    public ResponseEntity<?> handleTokenException(JwtTokenException ex, WebRequest request) {
        return buildApiError(ex.getMessage(), request, HttpStatus.FORBIDDEN);
    }


    // CONSTRUCTORES DE ERRORES
    private final ResponseEntity<Object> buildApiError(String message, WebRequest request, HttpStatus status) {
        return ResponseEntity
                .status(status)
                .body(ApiErrorImpl.builder()
                        .status(status)
                        .message(message)
                        .path(((ServletWebRequest) request).getRequest().getRequestURI())
                        .build()
                );
    }

    private final ResponseEntity<Object> buildApiErrorWithSubErrors(String message, WebRequest request, HttpStatus status, List<ObjectError> subErrors) {
        return ResponseEntity
                .status(status)
                .body(ApiErrorImpl.builder()
                        .status(status)
                        .message(message)
                        .path(((ServletWebRequest) request).getRequest().getRequestURI())
                        .subErrors(subErrors.stream()
                                .map(ApiValidationSubError::fromObjectError)
                                .collect(Collectors.toList())
                        )
                        .build()
                );
    }

}
