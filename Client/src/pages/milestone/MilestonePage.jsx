import React from 'react';
import { MilestoneIcon, CheckIcon } from '@primer/octicons-react';

import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import MilestoneList from '../../components/milestone/MilestoneList';
import Menu from '../../components/shared/container/Menu';
import NewButton from '../../components/shared/button/NewButton';
import styled from 'styled-components';
import MilestoneStore from '../../stores/MilestoneStore';

const MilestoneMenuContainer = styled.div`
  display: flex;
  margin: 0px 6px;
  align-items: center;
`;

const Title = styled.p`
  margin-left: 6px;
`;

export default function MilestonePage() {
  return (
    <MilestoneStore>
      <Container>
        <Menu name="milestone">
          <NewButton link="/milestone/post" name="milestone" />
        </Menu>
        <ItemContainer>
          <ItemHeader>
            <MilestoneMenuContainer>
              <MilestoneIcon />
              <Title>{0 + ' Open'}</Title>
            </MilestoneMenuContainer>
            <MilestoneMenuContainer>
              <CheckIcon />
              <Title>{0 + ' Closed'}</Title>
            </MilestoneMenuContainer>
          </ItemHeader>
          <MilestoneList />
        </ItemContainer>
      </Container>
    </MilestoneStore>
  );
}
