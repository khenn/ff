package FF;


our $VERSION = '0.0.1';
our $STATUS = 'alpha';


=head1 LEGAL

 -------------------------------------------------------------------
  TBD
 -------------------------------------------------------------------
  Please read the legal notices that came with this distribution
  before using this software.
  
  Currently there are no legal notices =)  This block is a placeholder
 -------------------------------------------------------------------
  http://www.tbd.com                     info@tbd.com
 -------------------------------------------------------------------

=cut

use strict;

=head1 NAME

Package FF

=head1 DESCRIPTION

This is a general API for FF.

=head1 SYNOPSIS

 use FF;

=head1 SUBROUTINES

These subroutines are available from this package:

=cut

#--------------------------------------------------------------------

=head2 new

 create a new instance of FF class

=cut

sub new {
   my $class = shift;
   
   my $self = {};
   $self->{_abbrvs} = {
        ARI => 'ARI', ATL => 'ATL', BAL => 'BAL', BUF => 'BUF',
        CAR => 'CAR', CHI => 'CHI', CIN => 'CIN', CLE => 'CLE',
        DAL => 'DAL', DEN => 'DEN', DET => 'DET', GB  => 'GB',
        HOU => 'HOU', IND => 'IND', JAC => 'JAC', JAX => 'JAC',
        KC  => 'KC', LAR => 'LAR', LA  => 'LAR', MIA => 'MIA',
        MIN => 'MIN', NE  => 'NE', NO  => 'NO', NYG => 'NYG',
        NYJ => 'NYJ', OAK => 'OAK', PHI => 'PHI', PIT => 'PIT',
        SD  => 'SD', SEA => 'SEA', SF  => 'SF', TB  => 'TB',
        TEN => 'TEN', WAS => 'WAS', WSH => 'WAS'  
    };
      
   bless $self, $class;
   return $self;
}

#-------------------------------------------------------------------

=head2 trim ( str )

trims and returns trimmed string

=head3 str

string to trim

=cut

sub trim {
    my $class = shift;
    my $str   = shift;
    $str =~ s/^\s+|\s+$//g;
    return $str;
}

#-------------------------------------------------------------------

=head2 getAbbrv ( abbrev )

returns the standard abbreviation for the team based on the abbreviation passed in.
This is needed because different sites have different abbreviations for the teams and
we need a standard set.

=head3 str

string to trim

=cut

sub getAbbrv {
    my $self  = shift;
    my $abbrv = shift;
    
    return $self->{_abbrvs}->{$abbrv};
}

1;

