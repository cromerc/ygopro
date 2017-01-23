--Number 6: Chronomaly Atlandis (Anime)
function c511002090.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9161357,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511002090.eqcon)
	e1:SetTarget(c511002090.eqtg)
	e1:SetOperation(c511002090.eqop)
	c:RegisterEffect(e1)
	--lp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9161357,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511002090.lpcost)
	e2:SetOperation(c511002090.lpop)
	c:RegisterEffect(e2)
	--lp - 0 materials
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(52090844,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511002090.hlpcon)
	e3:SetOperation(c511002090.hlpop)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c511002090.indcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--avoid battle damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetCondition(c511002090.indcon)
	c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511002090.indes)
	c:RegisterEffect(e6)
	if not c511002090.global_check then
		c511002090.global_check=true
		c511002090[0]=0
		c511002090[1]=0
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002090.numchk)
		Duel.RegisterEffect(ge2,0)
		--lpcheck
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(c511002090.lpchk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511002090.xyz_number=6
function c511002090.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
function c511002090.filter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_MONSTER)
end
function c511002090.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002090.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511002090.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c9161357.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511002090.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511002090.eqlimit)
		tc:RegisterEffect(e1)
		local atk=tc:GetBaseAttack()
		if atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(atk)
			tc:RegisterEffect(e2)
		end
	end
end
function c511002090.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511002090.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002090.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end
function c511002090.hlpcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()==0
end
function c511002090.hlpop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp/2)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
	if lp>1000 and Duel.GetLP(tp)<=1000 then
		Duel.RegisterFlagEffect(tp,51102090,0,0,0)
	end
end
function c511002090.indcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),51102090)>0
end
function c511002090.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,9161357)
	Duel.CreateToken(1-tp,9161357)
end
function c511002090.lpchk(e,tp,eg,ep,ev,re,r,rp)
	local prevlp1=c511002090[tp]
	local prevlp2=c511002090[1-tp]
	if prevlp1<=1000 and Duel.GetLP(tp)>1000 then
		Duel.ResetFlagEffect(tp,51102090)
	end
	if prevlp2<=1000 and Duel.GetLP(1-tp)>1000 then
		Duel.ResetFlagEffect(1-tp,51102090)
	end
	c511002090[tp]=Duel.GetLP(tp)
	c511002090[1-tp]=Duel.GetLP(1-tp)
end
function c511002090.indes(e,c)
	return not c:IsSetCard(0x48)
end
