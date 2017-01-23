--No.39 希望皇ホープ・ルーツ (Anime)
function c511010039.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010039,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511010039.atkcon)
	e1:SetCost(c511010039.atkcost)
	e1:SetTarget(c511010039.atktg)
	e1:SetOperation(c511010039.atkop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010039.indes)
	c:RegisterEffect(e6)
	if not c511010039.global_check then
		c511010039.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010039.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010039.xyz_number=39
function c511010039.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsType(TYPE_XYZ) and bc:IsFaceup() and bc:IsControler(1-tp)
end
function c511010039.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local g=c:GetOverlayGroup()
		if g:GetCount()>0 then
			local mg=g:Select(tp,1,1,nil)
			Duel.SendtoGrave(mg,REASON_COST)
			Duel.RaiseSingleEvent(c,EVENT_DETACH_MATERIAL,e,0,0,0,0)
			Duel.Overlay(bc,mg)
		end
end
function c511010039.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(e:GetHandler():GetBattleTarget())
end
function c511010039.ofilter(c)
	return c:GetOverlayCount()~=0
end
function c511010039.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.NegateAttack() and c:IsRelateToEffect(e) and c:IsFaceup() then
	local to=Duel.SelectMatchingCard(tp,c511010039.ofilter,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
	local toc=1
	local toc=to:GetOverlayCount()
	local atk=math.ceil(((tc:GetRank()-c:GetRank())*100)*toc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511010039.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,84124261)
	Duel.CreateToken(1-tp,84124261)
end
function c511010039.indes(e,c)
return not c:IsSetCard(0x48)
end