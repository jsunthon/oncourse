package oncourse.model.dao;

import java.util.List;

import oncourse.model.User;

public interface UserDao {

    User getUser( Long id );

    User getUserByCin( String cin );

    User getUserByUsername( String username );

    User saveUser( User user );
    
    List<User> getUsers();
}
