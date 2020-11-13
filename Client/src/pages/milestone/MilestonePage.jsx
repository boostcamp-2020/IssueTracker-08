import React from 'react';

import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import MilestoneList from '../../components/milestone/MilestoneList';
import Menu from '../../components/shared/container/Menu';
import NewButton from '../../components/shared/button/NewButton';
import MilestoneStore from '../../stores/MilestoneStore';
import MilestoneHeaderMenu from '../../components/milestone/MilestoneHeaderMenu';

export default function MilestonePage() {
  return (
    <MilestoneStore>
      <Container>
        <Menu name="milestone">
          <NewButton link="/milestone/post" name="milestone" />
        </Menu>
        <ItemContainer>
          <ItemHeader>
            <MilestoneHeaderMenu />
          </ItemHeader>
          <MilestoneList />
        </ItemContainer>
      </Container>
    </MilestoneStore>
  );
}
