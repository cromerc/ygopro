--No.100 ヌメロン・ドラゴン
function c57314798.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c57314798.xyzcon)
	e1:SetOperation(c57314798.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57314798,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c57314798.atkcost)
	e2:SetTarget(c57314798.atktg)
	e2:SetOperation(c57314798.atkop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57314798,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c57314798.descon)
	e3:SetTarget(c57314798.destg)
	e3:SetOperation(c57314798.desop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(57314798,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c57314798.spcon)
	e4:SetTarget(c57314798.sptg)
	e4:SetOperation(c57314798.spop)
	c:RegisterEffect(e4)
end
c57314798.xyz_number=100
function c57314798.xyzm12(c,xyz,tp)
	return c57314798.mfilter1(c,xyz,tp) or c57314798.mfilter2(c,xyz,tp)
end
function c57314798.mfilter1(c,xyzc,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_XYZ_MATERIAL))
end
function c57314798.mfilter2(c,xyzc,tp)
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsHasEffect(511002793) and c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc)
	else
		return c:IsHasEffect(511002116)
	end
end
function c57314798.xyzfilter1(c,tp,mg,xyz,matg,ct,sg,min,matct,nodoub)
	local tg
	local g=mg:Clone()
	if matg==nil or matg:GetCount()==0 then tg=Group.CreateGroup() else tg=matg:Clone() end
	g:RemoveCard(c)
	tg:AddCard(c)
	local tsg=false
	if sg then
		tsg=sg:Clone()
		tsg:RemoveCard(c)
	end
	local gg=tg:Filter(aux.ValidXyzMaterial,nil)
	if gg:IsExists(aux.TuneMagXyzFilter,1,nil,gg,tp) then return false end
	local ctc=ct+1
	local matct2=matct
	if not c:IsHasEffect(511002116) and min then
		matct2=matct+1
	end
	if min and matct2>min then return false end
	if (not min or matct2==min) and ctc>=2 and ctc<=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	if c:IsType(TYPE_XYZ) then g=g:Filter(c57314798.xyzfilter2,nil,c:GetCode(),c:GetRank()) end
	if ctc>2 then return false end
	local res2=false
	local eqg=c:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
	if not sg then
		g:Merge(eqg)
	end
	local isDouble=false
	if not nodoub and c:IsHasEffect(511001225) and (not c.xyzlimit2 or c.xyzlimit2(xyz)) then
		if ctc+1<=2 then
			isDouble=true
			res2=true
		end
		if (not min or matct2==min) and ctc+1>=2 and ctc+1<=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	end
	return g:IsExists(c57314798.xyzfilter1,1,nil,tp,g,xyz,tg,ctc,tsg,min,matct2,false) 
		or (res2 and g:IsExists(c57314798.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false))
end
function c57314798.xyzfilter2(c,code,rk)
	return (c:IsCode(code) and c:GetRank()==rk) or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c57314798.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	local sg=false
	if og then
		mg=og:Filter(c57314798.xyzm12,nil,c,tp)
		sg=mg:Clone()
		local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
		mg:Merge(mg2)
	else
		mg=Duel.GetMatchingGroup(c57314798.mfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		local mg2=Duel.GetMatchingGroup(c57314798.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
		mg:Merge(mg2)
	end
	local minchk=min
	if c:GetFlagEffect(999)~=0 then minchk=nil end
	return mg:IsExists(c57314798.xyzfilter1,1,nil,tp,mg,c,nil,0,sg,minchk,0,false)
end
function c57314798.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	if og and not min then
		if not og:IsExists(c57314798.xyzfilter1,1,nil,tp,og,c,nil,0,og,og:GetCount(),0,false) then
			local matg=Group.CreateGroup()
			local mg=og:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
			local ct=og:GetCount()
			tog=og:Clone()
			local tc=tog:GetFirst()
			local matct=0
			local ct=0
			while tc do
				local isDouble=false
				if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2 
					and (not c57314798.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true) or Duel.SelectYesNo(tp,65)) then
					isDouble=true
				end
				ct=ct+1
				if isDouble then ct=ct+1 end
				matct=matct+1
				mg:RemoveCard(tc)
				matg:AddCard(tc)
				tc=tog:GetNext()
			end
			while ct<2 do
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
				local sg=mg:Select(tp,1,1,nil)
				sg:GetFirst():RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
				ct=ct+1
				mg:Sub(sg)
				matg:Merge(sg)
			end
			matg:Remove(Card.IsHasEffect,nil,511002116)
			matg:Remove(Card.IsHasEffect,nil,511002115)
			local sg=Group.CreateGroup()
			local tc=matg:GetFirst()
			while tc do
				local sg1=tc:GetOverlayGroup()
				sg:Merge(sg1)
				tc=g:GetNext()
			end
			Duel.SendtoGrave(sg,REASON_RULE)
			c:SetMaterial(g)
			Duel.Overlay(c,g)
		else
			local sg=Group.CreateGroup()
			local tc=og:GetFirst()
			while tc do
				local sg1=tc:GetOverlayGroup()
				sg:Merge(sg1)
				tc=og:GetNext()
			end
			Duel.SendtoGrave(sg,REASON_RULE)
			c:SetMaterial(og)
			Duel.Overlay(c,og)
		end
	else
		local mg
		local sg=false
		if og then
			mg=og:Filter(c57314798.xyzm12,nil,c,tp)
			sg=mg:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
		else
			mg=Duel.GetMatchingGroup(c57314798.xyzm12,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
			local mg2=Duel.GetMatchingGroup(c57314798.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
			mg:Merge(mg2)
		end
		local ct=0
		local matg=Group.CreateGroup()
		while ct<2 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=mg:FilterSelect(tp,c57314798.xyzfilter1,1,1,nil,tp,mg,c,matg,ct,sg,nil,nil,false)
			local tc=g:GetFirst()
			local isDouble=false
			if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2
				and (not c57314798.xyzfilter1(tc,tp,mg,c,matg,ct,sg,nil,nil,true) or Duel.SelectYesNo(tp,65)) then
				isDouble=true
			end
			if isDouble then ct=ct+1 end
			if not sg then
				local eqg=tc:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
				mg:Merge(eqg)
			end
			mg:RemoveCard(tc)
			matg:AddCard(tc)
			if tc:IsHasEffect(511002116) then
				tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			if tc:IsType(TYPE_XYZ) then mg=mg:Filter(c57314798.xyzfilter2,nil,tc:GetCode(),tc:GetRank()) end
			ct=ct+1
		end
		matg:Remove(Card.IsHasEffect,nil,511002116)
		matg:Remove(Card.IsHasEffect,nil,511002115)
		local sg2=Group.CreateGroup()
		local tc=matg:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg2:Merge(sg1)
			tc=matg:GetNext()
		end
		Duel.SendtoGrave(sg2,REASON_RULE)
		c:SetMaterial(matg)
		Duel.Overlay(c,matg)
	end
end
function c57314798.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c57314798.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetRank()>0
end
function c57314798.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57314798.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c57314798.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c57314798.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local atk=g:GetSum(Card.GetRank)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk*1000)
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
			c:RegisterEffect(e1)
		end
	end
end
function c57314798.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c57314798.setfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c57314798.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,2,PLAYER_ALL,LOCATION_GRAVE)
end
function c57314798.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g1=Duel.SelectMatchingCard(tp,c57314798.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SET)
		local g2=Duel.SelectMatchingCard(1-tp,c57314798.setfilter,1-tp,LOCATION_GRAVE,0,1,1,nil)
		local tc1=g1:GetFirst()
		local tc2=g2:GetFirst()
		if (tc1 and tc1:IsHasEffect(EFFECT_NECRO_VALLEY)) or (tc2 and tc2:IsHasEffect(EFFECT_NECRO_VALLEY)) then return end
		if tc1 then
			Duel.SSet(tp,tc1)
			Duel.ConfirmCards(1-tp,tc1)
		end
		if tc2 then
			Duel.SSet(1-tp,tc2)
			Duel.ConfirmCards(tp,tc2)
		end
	end
end
function c57314798.spfilter(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c57314798.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
		and not Duel.IsExistingMatchingCard(c57314798.spfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil)
end
function c57314798.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c57314798.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
