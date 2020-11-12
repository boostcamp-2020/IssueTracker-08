import React from 'react';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import Menu from '../../components/shared/container/Menu';
import NewButton from '../../components/shared/button/NewButton';

export default function MilestonePage() {
  return (
    <Container>
      <Menu name="milestone">
        <NewButton link="/milestone/post" name="milestone" />
      </Menu>
      <ItemContainer>
        <ItemHeader />
      </ItemContainer>
    </Container>
  );
}
