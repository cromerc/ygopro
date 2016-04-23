--デステニー・オーバーレイ
function c100000490.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000490.target)
	e1:SetOperation(c100000490.activate)
	c:RegisterEffect(e1)
end
function c100000490.xyzfilter(c,mg)
	if c.xyz_count~=mg:GetCount() then return false end
	return c:IsXyzSummonable(mg)
end
function c100000490.mfilter1(c,exg,mg2,mg1)
	return exg:IsExists(c100000490.mfilter2,1,nil,c,mg2,exg,mg1)
end
function c100000490.mfilter2(c,mc,mg2,exg,mg1)
	return c.xyz_filter(mc) and mg2:Filter(c100000490.mfilter3,nil,exg,mc,mg1,mg2)
end
function c100000490.mfilter3(c,exg,tc,mg1,mg2)
	return exg:IsExists(c100000490.mfilter4,1,nil,c,tc,mg1,mg2,exg)
end
function c100000490.mfilter4(c,mc,tc,mg1,mg2,exg)
	local mg=Group.CreateGroup()
	if c.xyz_count>2 then
		mg:Merge(mg1)
		mg:Merge(mg2)
	return c.xyz_filter(mc) and mg:FilterCount(c100000490.mfilter10,nil,exg,mc,tc)+2==c.xyz_count
	else
	return c.xyz_filter(mc)
	end
end
function c100000490.mfilter5(c,exg)
	return exg:IsExists(c100000490.mfilter6,1,nil,c)
end
function c100000490.mfilter6(c,mc)
	return c.xyz_filter(mc)
end
function c100000490.mfilter7(c,mc,mg2,exg,mg1)
	local tc=mc:GetFirst()
	local ct=mc:GetCount()
	while tc and ct>0 do
		if c.xyz_filter(tc)==0 or mg2:FilterCount(c100000490.mfilter3,nil,exg,tc,mg1,mg2)==0 then return false end
		ct=ct-1
		tc=mc:GetNext()
	end
	if ct<1 then return true end
end
function c100000490.mfilter8(c,exg,tc,mg2)
	return exg:IsExists(c100000490.mfilter9,1,nil,c,tc,mg2,exg)
end
function c100000490.mfilter9(c,mc,tc,mg2,exg)
	local g=tc:GetFirst()
	local ct=tc:GetCount()
	while g and ct>0 do
		if c.xyz_filter(g)==0 or mg2:FilterCount(c100000490.mfilter5,nil,exg,g,mg2)~=ct-1 then return false end
		ct=ct-1
		tc=mc:GetNext()
	end
	if ct<1 then return true end
end
function c100000490.mfilter10(c,exg,mc,tc)
	return c~=mc and c~=tc and exg:IsExists(c100000490.mfilter6,1,nil,c)
end
function c100000490.mfilter(c,e)
	return c:IsCanBeEffectTarget(e) and c:IsFaceup()
end
function c100000490.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg1=Duel.GetMatchingGroup(c100000490.mfilter,tp,0,LOCATION_MZONE,nil,e)
	local mg2=Duel.GetMatchingGroup(c100000490.mfilter,tp,LOCATION_MZONE,0,nil,e)
	local exg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_EXTRA,0,nil,TYPE_XYZ)
	local mg=Duel.GetMatchingGroup(c100000490.mfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	local sg=mg:Filter(c100000490.mfilter1,nil,exg,mg2,mg1)
	if chk==0 then return (not Duel.IsPlayerAffectedByEffect(tp,100000490) or c100000490[tp]==0)
		and mg1:GetCount()>0 and mg2:GetCount()>0 and sg:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local ct=2
	local cg=exg:GetFirst()
	while cg do
		if cg.xyz_count>ct then ct=cg.xyz_count end
		cg=exg:GetNext()
	end
	local sg1=mg1:FilterSelect(tp,c100000490.mfilter1,1,ct-1,nil,exg,mg2,mg1)
	local exg2=exg:Filter(c100000490.mfilter7,nil,sg1,mg2,exg,mg1)
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg2=mg2:FilterSelect(tp,c100000490.mfilter3,1,ct-sg1:GetCount(),nil,exg,nil,sg1,mg2)
	sg1:Merge(sg2)
	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,2,0,0)
end
function c100000490.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,100000490) and c100000490[tp]>0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()<2 then return end
	local xyzg=Duel.GetMatchingGroup(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end