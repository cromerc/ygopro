--ＣＸ 熱血指導神アルティメットレーナー
function c100000451.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,9),4)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100000451.recon)
	e1:SetOperation(c100000451.reop)
	c:RegisterEffect(e1)
	--immune spell
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000451.condition)
	e3:SetValue(c100000451.efilter)
	c:RegisterEffect(e3)
end
function c100000451.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,30741334)
end
function c100000451.reop(e,tp,eg,ep,ev,re,r,rp)
	--damage
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetLabel(0)
	e2:SetCost(c100000451.cost)
	e2:SetTarget(c100000451.damtg)
	e2:SetOperation(c100000451.damop)
	e:GetHandler():RegisterEffect(e2)
end 
function c100000451.condition(e)
	return e:GetHandler():GetFlagEffect(100000451)==0
end
function c100000451.efilter(e,te,r,rp)
	if te:IsActiveType(TYPE_EFFECT) then
		e:GetHandler():RegisterFlagEffect(100000451,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
	return te:IsActiveType(TYPE_EFFECT)
end
function c100000451.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)
		and Duel.IsPlayerCanDraw(1-tp,1) end
	local t={}
	local l=1
	while e:GetHandler():CheckRemoveOverlayCard(tp,l,REASON_COST) and Duel.IsPlayerCanDraw(1-tp,l) do
		t[l]=l
		l=l+1
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000451,0))
	local announce=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetLabel(announce)
	e:GetHandler():RemoveOverlayCard(tp,announce,announce,REASON_COST)
end
function c100000451.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,dam)
end
function c100000451.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	while d~=0 and tc do
		Duel.Draw(1-tp,1,REASON_EFFECT)
		Duel.ConfirmCards(tp,tc)		
		if tc:IsType(TYPE_MONSTER) then
			if tc:IsLevelBelow(4) then
				Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
			end
		end
		Duel.BreakEffect()
		Duel.SendtoGrave(tc,REASON_EFFECT)
		g=Duel.GetDecktopGroup(1-tp,1)
		tc=g:GetFirst()
		d=d-1
	end
end
