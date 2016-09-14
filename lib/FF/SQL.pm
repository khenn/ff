package FF::SQL;

use strict;
use Data::Dumper;
use DBI;

=head1 NAME

Package FF::SQL

=head1 DESCRIPTION

Helper SQL Class.  Maybe change this to be a wrapper for DBI::Class someday.

=head1 SYNOPSIS

    use FF::SQL;

=head1 METHODS

These subroutines are available from this package:

=cut

#-------------------------------------------------------------------

=head2 connect ( dsn, user, pass )

Constructor. Connects to the database using DBI.

=head2 dsn

The Database Service Name of the database  you wish to connect to. It looks like 'DBI:mysql:dbname;host=localhost'.

=head2 user

The username to use to connect to the database defined by dsn.

=head2 pass

The password to use to connect to the database defined by dsn.

=cut

sub connect {
	my $class   = shift;
	my $dsn     = shift;
	my $user    = shift;
	my $pass    = shift;

    my (undef, $driver) = DBI->parse_dsn($dsn);
    my $dbh = DBI->connect($dsn,$user,$pass,{RaiseError => 0, AutoCommit => 1,
        $driver eq 'mysql' ? (mysql_enable_utf8 => 1) : (),
    });

	unless (defined $dbh) {
		print "Couldn't connect to database: $dsn : $DBI::errstr";
		return undef;
	}

	my $self = bless { _dbh=>$dbh }, $class;
    return $self;
}

#-------------------------------------------------------------------

=head2 dbh ( )

Returns a reference to the working DBI database handler for this object.

=cut

sub dbh {
	my $self = shift;
	return $self->{_dbh};
}


#-------------------------------------------------------------------

=head2 fetchrow_array (sql, param1, param2, ...)

Executes the SQL statement passed in with the params provided.  Returns
a result array reference

=head2 sql

SQL query to run

=head2 params

paramters to pass into query

=cut

sub fetchrow_array {
    my $self   = shift;
    my $sql    = shift;
    my @params = @_;
    
    my $sth = $self->dbh->prepare($sql);
    $sth->execute(@params);
    my @result = $sth->fetchrow_array();
    $sth->finish;
    
    return \@result;
}

#-------------------------------------------------------------------

=head2 fetchall_arrayref (sql, param1, param2, ...)

Executes the SQL statement passed in with the params provided.  Assumes that one return
value is expected and returns the value:

ex:  select column from table where id=?

=head2 sql

SQL query to run

=head2 params

paramters to pass into query

=cut

sub fetchall_arrayref {
    my $self   = shift;
    my $sql    = shift;
    my @params = @_;
    
    my $sth = $self->dbh->prepare($sql);
    $sth->execute(@params);
    my $result = $sth->fetchall_arrayref([]);
    $sth->finish;
    
    return $result;
}

#-------------------------------------------------------------------

=head2 delete_row (sql, param1, param2, ...)

Executes a delete statement

=head2 sql

SQL query to run

=head2 params

paramters to pass into query

=cut

sub delete_row {
    insert_row(@_);
}

#-------------------------------------------------------------------

=head2 update_row (sql, param1, param2, ...)

Executes an update statement

=head2 sql

SQL query to run

=head2 params

paramters to pass into query

=cut

sub update_row {
    insert_row(@_);
}

#-------------------------------------------------------------------

=head2 insert_row (sql)

Executes an insert statement

=head2 sql

SQL query to run

=head2 params

paramters to pass into query

=cut

sub insert_row {
    my $self   = shift;
    my $sql    = shift;
    my @params = @_;
    
    my $sth = $self->dbh->prepare($sql);
    $sth->execute(@params);
    $sth->finish;
    
}

1;